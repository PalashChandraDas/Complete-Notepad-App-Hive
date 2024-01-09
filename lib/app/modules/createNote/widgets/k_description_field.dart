import 'package:flutter/material.dart';

import '../../../../utils/custom_strings.dart';


class KDescriptionField extends StatelessWidget {
  const KDescriptionField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 1,
      maxLines: 20,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: CustomStrings.descriptionHint,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
