import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final bool? enabled;

  const LoginTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.normal,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      validator: validator,
      enabled: enabled,
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? enabled;

  const PasswordTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.enabled,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.normal,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: _toggleVisibility,
        ),
      ),
      validator: widget.validator,
      enabled: widget.enabled,
    );
  }
}
