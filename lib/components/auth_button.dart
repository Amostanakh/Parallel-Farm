import 'package:flutter/material.dart';
import 'package:parallel_farm/constants/constants.dart';


class AuthButton extends StatelessWidget {
  final void Function() onChanged;
  final String name;


  const AuthButton({  required this.onChanged,required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/greenbutton.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: TextButton(
        onPressed: onChanged,
        child:  Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}




