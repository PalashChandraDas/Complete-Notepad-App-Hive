import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_pad_hive/theme/app_theme.dart';
import 'package:note_pad_hive/utils/custom_strings.dart';
import 'package:provider/provider.dart';

import 'app/modules/note/model/note.dart';
import 'app/modules/note/provider/note_provider.dart';
import 'app/modules/note/view/note_view.dart';

void main() async {
  log('main() called--------------');
  // 3 lines for hive setup
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log('MyApp build() called--------------');
    return MaterialApp(
      title: CustomStrings.appName,
      home: NoteView(),
      theme: AppTheme.appTheme,
    );
  }
}
