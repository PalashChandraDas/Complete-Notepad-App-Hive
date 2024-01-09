import 'package:flutter/material.dart';

import '../../../../utils/custom_strings.dart';

class KTitleField extends StatelessWidget {
  const KTitleField({super.key, required this.controller,});

  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: CustomStrings.titleHint,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
    );
  }
}
