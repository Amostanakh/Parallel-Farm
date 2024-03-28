import 'package:flutter/material.dart';

Future<void> successdisplayTextInputDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          title: const Column(
            children: [
              Icon(Icons.send_sharp),
              Text(
                "Adoption Success",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text('you have successfully Addopted 200 animals'),
          actions: <Widget>[
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                // setState(() {
                //   Navigator.pop(context);
                // });
              },
            ),
          ],
        );
      });
}
