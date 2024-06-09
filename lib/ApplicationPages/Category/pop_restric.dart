
import 'package:flutter/material.dart';
import 'package:grad_test_1/ApplicationPages/Category/category.dart';
import 'package:grad_test_1/generated/l10n.dart';



class PopRestrict extends StatefulWidget {
  const PopRestrict({super.key,this.currentLocale,this.onLanguageChange});
    final void Function(Locale, String)? onLanguageChange;
  final Locale? currentLocale;

  @override
  State<PopRestrict> createState() => _PopRestrictState();
}

class _PopRestrictState extends State<PopRestrict> {
  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(S.of(context).ays),
          content: Text.rich(
            TextSpan(
              text: S.of(context).wtl,
              style: const TextStyle(color:Colors.grey),
              children: [
                TextSpan(text: S.of(context).pharmaTails,style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold))
              ] )
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child:  Text(S.of(context).nvm),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child:  Text(S.of(context).leave),
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
          child: CategorySelector(currentLocale: widget.currentLocale,onLanguageChange: widget.onLanguageChange,)),
    );
  }
}
