import 'package:flutter/material.dart';
import 'package:parallel_farm/components/outline_text.dart';

class Already extends StatelessWidget {
  final void Function() onChanged;
  final String name;
  const Already({ required this.onChanged,required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       const OutlineText(text: 'Already have an account?',color: false,),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: onChanged,
          child: OutlineText(text:name,color: true,)
        ),
      ],
    );
  }
}
