import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_pad_hive/app/modules/note/provider/note_provider.dart';
import 'package:provider/provider.dart';

import '../app/modules/mainApp/provider/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: [
        Consumer<ThemeProvider>(builder: (context, value, child) {
          return IconButton(
              icon: Icon(value.isDarkMode
                  ? Icons.nightlight_round
                  : Icons.light_mode),
              onPressed: () {
                value.toggleTheme();
              });

        },),



        Consumer<NoteProvider>(
          builder: (context, value, child) {
            return value.isToggleVisible
                ? Checkbox(
                    value: value.isSelectedPermission,
                    onChanged: (newValue) {
                      if (value.isSelectedPermission == false) {
                        value.toggleSelectAll(
                            noteBox: value.noteBox, selectAll: true);
                        value.selectedPermission();
                        log('select all*******************');
                      } else {
                        value.toggleSelectAll(
                            noteBox: value.noteBox, selectAll: false);
                        value.selectedPermission();
                        log('unselect all*******************');
                      }

                      log('newValue++++++++++$newValue');
                    },
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }


}
