import 'package:earning/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.textInputType = TextInputType.text,
  });

  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final TextInputType textInputType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();}

class _CustomTextFieldState extends State<CustomTextField> {

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      obscureText: widget.isPassword ? obscureText : false,
      validator: widget.validator,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: AppColors.blackColor
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: widget.isPassword ? GestureDetector(
            onTap: toggle,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, top: 20, bottom: 20, end: 12),
              child: obscureText ?
              const Icon(Icons.visibility_off_outlined) :
              const Icon(Icons.visibility_outlined),
            ))
            : null,
        prefixIcon: widget.prefixIcon != null? Padding(
          padding: const EdgeInsetsDirectional.only(start: 10, top: 6, bottom: 6, end: 6),
          child: Icon(widget.prefixIcon),
        ): null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blackColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blackColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blackColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.redColor),
        ),
        hintText: widget.hintText,
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}