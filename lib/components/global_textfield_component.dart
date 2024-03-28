import 'package:flutter/material.dart';
import 'package:parallel_farm/constants/constants.dart';


class GlobalTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final String? helperText;
  final bool enabled;
  final bool obscureText;
  final TextInputType textInputType;
  final double height;
  final double textSize;
  final Color fillColor;
  final int maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final AutovalidateMode? autoValidateMode;

  const GlobalTextField(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      this.hintText = "",
      this.enabled = true,
      this.maxLines = 1,
      this.maxLength,
      this.height = 70,
      this.fillColor = secondaryColor,
      this.textSize = 12,
      this.focusNode,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted,
      this.prefixIcon,
      this.autoValidateMode,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.helperText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6.0,
        bottom: 4.0,
      ),
      child: SizedBox(
        height: height,
        child: TextFormField(
          obscureText: obscureText,
          controller: textEditingController,
          maxLines: maxLines,
          maxLength: maxLength,
          enabled: enabled,
          focusNode: focusNode,
          style: TextStyle(
            fontSize: textSize,
          ),
          keyboardType: textInputType,
          cursorColor: primaryColor,
          decoration: InputDecoration(
              fillColor: fillColor.withOpacity(0.5),

              hintText: hintText,
              helperText: helperText,
              label: Text(
                labelText,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 3.0,color: primaryColor)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),


                  borderSide: BorderSide(color: primaryColor,width: 3.0)),



              prefixIcon: prefixIcon),
          validator: validator ??
              (val) {
                if (val == null || val.isEmpty) {
                  return "Please enter $labelText";
                }
                return null;
              },
          autovalidateMode: autoValidateMode,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
