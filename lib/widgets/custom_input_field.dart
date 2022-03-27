import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final bool obscureText;
  final String formProperty;
  final Map<String, String> formValues;
  String textLength;

  CustomInputField({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.textInputType,
    this.textLength = '0',
    this.obscureText = false,
    required this.formProperty,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      initialValue: formValues[formProperty],
      textCapitalization: TextCapitalization.words,
      keyboardType: textInputType,
      obscureText: obscureText,
      onChanged: (value) {
        formValues[formProperty] = value;
        textLength = formValues[formProperty]!.split(',').length.toString();
      },
      validator: (value) {
        if (value == null) return 'Este campo es requerido';
        return value.length < 3 ? 'Mínimo 3 letras' : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        counterText: '3 Caracteres',
        // prefixIcon: Icon(Icons.group_add_outlined),
        icon: icon == null ? null : Icon(icon),
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
      ),
    );
  }
}
