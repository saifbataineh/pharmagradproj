import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


class LocateDrugPage extends StatefulWidget {
  final String searchedDrug;
  const LocateDrugPage({super.key, required this.searchedDrug});
  
  @override
  State<LocateDrugPage> createState() => _LocateDrugState();

}
class _LocateDrugState extends State<LocateDrugPage> {
  GoogleMapController? _mapController;
  List<Marker> pharmacyMarkers = [];
  Location location =  Location();
  LatLng? _currentPosition;
  Circle? _radarCircle;
  late BitmapDescriptor pharmacyMarkerIcon;
  late BitmapDescriptor homeMarkerIcon;
  LatLng? _nearestMarkerPosition;
  
  customMarker() async {
    pharmacyMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 'assets/icons/pharmacy-location.png');

    homeMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 'assets/icons/home-location.png');
    
    setState(() {
      homeMarkerIcon;
      pharmacyMarkerIcon;
    });
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    const int earthRadius = 6371000; // Radius of the Earth in meters
    double lat1 = point1.latitude * (pi / 180);
    double lon1 = point1.longitude * (pi / 180);
    double lat2 = point2.latitude * (pi / 180);
    double lon2 = point2.longitude * (pi / 180);
    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }
  void _findNearestMarker() {
    if (_currentPosition != null && pharmacyMarkers.isNotEmpty) {
      double minDistance = double.infinity;
      Marker? nearestMarker;
      for (Marker marker in pharmacyMarkers) {
        double distance = _calculateDistance(_currentPosition!, marker.position);
        if (distance < minDistance) {
          minDistance = distance;
          nearestMarker = marker;
        }
      }
      if (nearestMarker != null) {
        setState(() {
          _nearestMarkerPosition = nearestMarker?.position;
        });
      }
    }
  }

  Future<void> loadDrugLocations(drugName) async {
    final jsonString = await rootBundle.loadString('assets/json/drug_location.json');
    final jsonData = jsonDecode(jsonString);
    
    List<dynamic> pharmacies = jsonData['pharmacy'];
   
    List<Marker> updatedMarkers = [];
    
    for (var pharmacy in pharmacies) {
      final pharmacyName = pharmacy['name'];
      final drugStock = pharmacy['drug_stock'];
      final placeID = pharmacy['place_id'];
      final lat = pharmacy['geometry']['location']['lat'];
      final lng = pharmacy['geometry']['location']['lng'];
      final pharmacyLocation = LatLng(lat, lng);
      final openingHours = pharmacy['opening_hours'];
      final isOpen = openingHours != null && openingHours['open_now'] == true;
  
      if(drugStock.any((drug) => drug.toString().trim().toLowerCase().contains(
        drugName.toString().trim().toLowerCase()))) {
          
        final locationMarker = Marker(
          markerId: MarkerId(placeID),
          position: pharmacyLocation,
          icon: pharmacyMarkerIcon, // Use the pharmacy marker icon
          infoWindow: InfoWindow(
            title: pharmacyName,
            snippet: isOpen ? 'Open Now' : 'Closed',
          ),
        );
        updatedMarkers.add(locationMarker);
      }
    }
    setState(() {
      pharmacyMarkers = updatedMarkers;
    });
  }
  

  @override
  void initState() {
    super.initState();
    customMarker();
    loadDrugLocations(widget.searchedDrug);
    getLocationUpdates();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      handleConnectivityOnline(result);
    });
    checkConnectivity();
    _findNearestMarker();
  }
 
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
 
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text(widget.searchedDrug),
    ),
    body:
    _currentPosition == null ? 
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color.fromARGB(255, 146, 82, 220)),
          SizedBox(height: 15),
          Text("Loading Locations...")
        ],
      )) 
      : pharmacyMarkers.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No pharmacies located with ${widget.searchedDrug}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Return'),
                    ),
                  ],
                ),
              )
      :
      GoogleMap(
        initialCameraPosition: CameraPosition(
      target: _nearestMarkerPosition!,
      zoom: 12,
      ),
      markers: { ...pharmacyMarkers,
        Marker(
            markerId: const MarkerId("currentPosition"),
            position: _currentPosition!,
            icon: homeMarkerIcon, 
            infoWindow: const InfoWindow(title: "Your Location"),
          )},
      circles: Set.of((_radarCircle != null) ? [_radarCircle!] : []),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        } // Add the radar circle
      ),
    );     
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    handleConnectivityChange(connectivityResult);
  }

  void handleConnectivityChange(ConnectivityResult connectivityResult) {
    if (!mounted) return;
    if (connectivityResult == ConnectivityResult.none) {
      showNoInternetSnackBar();

    }
  }
  void handleConnectivityOnline(ConnectivityResult connectivityResult) {
    if (!mounted) return;
    if (connectivityResult != ConnectivityResult.none) {
      showInternetSnackBar();
    }
  }

  void showNoInternetSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Check your internet connection for better usage to directions and location information.'),
        backgroundColor: Colors.red,
      ),
    );
  }
  void showInternetSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Connect to Maps...'),
        backgroundColor: Colors.green,
      ),
    );
  }

//Location Updates:
  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    if (!_serviceEnabled) {

      if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location Service Disabled.'),
            backgroundColor: Colors.red,
          ),
        );
      Navigator.of(context).pop();
      return;
    }
    
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location Access Denied.'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.of(context).pop();
      return;
      }
    }
//Listening to current location
    location.onLocationChanged.listen((LocationData currentLocation) {
      if(currentLocation.latitude != null && currentLocation.longitude != null) {
        if(mounted) {
          setState(() {
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _radarCircle = Circle(
            circleId: const CircleId("radar_circle"),
            center: _currentPosition!,
            radius: 1500,
            fillColor: const Color.fromRGBO(171, 39, 133, 0.1),
            strokeColor: const Color.fromRGBO(171, 39, 133, 0.5),
            strokeWidth: 1,
          );
          _findNearestMarker();
        });
        }
      }
    });
  }
}