import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isHidden;

  @override
  void initState() {
    super.initState();
    isHidden = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      obscureText: isHidden,
      validator: widget.validator,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintText: widget.hintText,

        fillColor: theme.colorScheme.surface, 
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  isHidden ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: () => setState(() => isHidden = !isHidden),
              )
            : null,
            
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: theme.colorScheme.secondary, width: 2),
        ),
      ),
    );
  }
}