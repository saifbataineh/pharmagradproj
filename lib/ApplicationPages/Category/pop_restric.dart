
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/Category/category.dart';



class PopRestrict extends StatefulWidget {
  const PopRestrict({super.key});

  @override
  State<PopRestrict> createState() => _PopRestrictState();
}

class _PopRestrictState extends State<PopRestrict> {
  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content:const Text.rich(
            TextSpan(
              text: 'you want to leave ',
              style: TextStyle(color:Colors.grey),
              children:[
                TextSpan(text: '  Pharma Tails ?',style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold))
              ] )
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            _showBackDialog();
          },
          child: CategorySelector()),
    );
  }
}
