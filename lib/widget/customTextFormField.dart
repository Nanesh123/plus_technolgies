import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      this.controller,
      this.validator,
      this.maxLength,
      this.keyboardType});

  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: controller,
                validator: validator,
                maxLength: maxLength,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: label,
                  border: InputBorder.none,
                  counter: const Offstage(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
