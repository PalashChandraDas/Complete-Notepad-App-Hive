import 'package:flutter/material.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: [
        IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.light_mode)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
