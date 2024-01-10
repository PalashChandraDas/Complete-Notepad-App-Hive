import 'package:flutter/material.dart';

class KListTitle extends StatelessWidget {
  const KListTitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
