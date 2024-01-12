import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_pad_hive/utils/custom_strings.dart';
import 'package:provider/provider.dart';

import 'app/modules/mainApp/provider/theme_provider.dart';
import 'app/modules/note/model/note.dart';
import 'app/modules/note/provider/note_provider.dart';
import 'app/modules/note/view/note_view.dart';


void main() async {
  log('main() called--------------');
  // 3 Lines for hive setup
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NoteProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: CustomStrings.appName,
      debugShowCheckedModeBanner: false,
      theme:  Provider.of<ThemeProvider>(context).themeData,
      home: const NoteView(),
    );
  }
}
