import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
  GoogleMapController? _mapController;
  static const apiKey = "AIzaSyBVolKgX0PD7cHvAtf8HBWoPoz6Lzyvn2g";
  var url = "";
  List<Marker> pharmacyMarkers = [];
  bool _pharmacyLocationsFetched = false;
  Location location =  Location();
  LatLng? _currentPosition;
  Circle? _radarCircle;
  //Icons
  late BitmapDescriptor pharmacyMarkerIcon;
  late BitmapDescriptor homeMarkerIcon;
  
  //Custom Icons:
  customMarker() async {
    pharmacyMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 'assets/icons/pharmacy-location.png');

    homeMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 'assets/icons/home-location.png');
  }

  
  
  @override
  void initState() {
    super.initState();
    getLocationUpdates();
    customMarker();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      handleConnectivityOnline(result);
    });
    checkConnectivity();
    
  }
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  
  @override

   Widget build(BuildContext context) {
    return Scaffold(
      
      body:
      _currentPosition == null || pharmacyMarkers.isEmpty ? 
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color.fromARGB(255, 146, 82, 220)),
            SizedBox(height: 15),
            Text("Loading Locations...")
          ],
        )) :
         
        GoogleMap(initialCameraPosition: CameraPosition(
        target: _currentPosition!,
        zoom: 15.3,
        ),
        markers: {...pharmacyMarkers, Marker(
              markerId: const MarkerId("currentPosition"),
              position: _currentPosition!,
              icon: homeMarkerIcon, // Use your home marker icon
              infoWindow: const InfoWindow(title: "Your Location"),
            )},//here to display markers,
        circles: Set.of((_radarCircle != null) ? [_radarCircle!] : []),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        } // Add the radar circle
        ),
    );
  }

  Future<void> fetchPharmacyLocations() async {
    
    final response = await http.get(Uri.parse(url));
   
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final results = data['results'];
        pharmacyMarkers.clear();
        for (var pharmacy in results) {
          final lat = pharmacy['geometry']['location']['lat'];
          final lng = pharmacy['geometry']['location']['lng'];
          final pharmacyPosition = LatLng(lat, lng);

          final openingHours = pharmacy['opening_hours'];
          final isOpen = openingHours != null && openingHours['open_now'] == true;

          final pharmacyMarker = Marker(
            markerId: MarkerId(pharmacy['place_id']),
            position: pharmacyPosition,
            icon: pharmacyMarkerIcon,
            infoWindow: InfoWindow(
              title: pharmacy['name'],
              snippet: isOpen ? 'Open Now' : 'Closed',
              ),
          );
          pharmacyMarkers.add(pharmacyMarker);
        }
      }
    }
  }




//Connectivity:
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
        content: Text('No Internet Connection, Check your internet connection.'),
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
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    if (!serviceEnabled) {

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
    
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
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
            radius: 750,
            fillColor: const Color.fromRGBO(171, 39, 133, 0.1),
            strokeColor: const Color.fromRGBO(171, 39, 133, 0.5),
            strokeWidth: 1,
          );

          // Check if pharmacy locations have already been fetched
          if (!_pharmacyLocationsFetched) {
            _pharmacyLocationsFetched = true; // Set flag to prevent further fetching
            url = "https://maps.googleapis.com/maps/api/place/textsearch/json?location=${_currentPosition!.latitude},${_currentPosition!.longitude}&query=pharmacies%20and%20drug%20store&radius=300&type=pharmacy&key=$apiKey";
            fetchPharmacyLocations();
          }
        });
      }
    }
    // Remove location update listener after fetching pharmacy locations
    if (_pharmacyLocationsFetched) {
      location.onLocationChanged.listen(null);
    }
  });
 }
}