import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_pad_hive/app/modules/createNote/view/create_note_view.dart';
import 'package:note_pad_hive/app/routes/custom_router.dart';
import 'package:provider/provider.dart';

import '../../../../utils/custom_strings.dart';
import '../model/note.dart';
import '../provider/note_provider.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    log('NoteViewBuild() called--------------');

    return Scaffold(
      appBar: AppBar(
        title: const Text(CustomStrings.appName),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            CustomRouter.push(context: context, page: CreateNoteView());
          },
          child: const Icon(Icons.add)),
      body: Column(
        children: [

          Consumer<NoteProvider>(
            builder: (context, value, child) {
              return value.noteBox.isEmpty
                  ? const Center(
                      child: Text(CustomStrings.emptyNote),
                    )
                  : Expanded(
                    child: ListView.builder(
                        itemCount: value.noteBox.length,
                        itemBuilder: (context, i) {
                          // Store items in this variable
                          final Note note = value.noteBox.getAt(i)!;
                          return ListTile(
                            title: Text(note.title!, maxLines: 1, overflow: TextOverflow.ellipsis,),
                            subtitle: Text(note.content!, maxLines: 1, overflow: TextOverflow.ellipsis),
                            onTap: () {
                              log('route page----------->');
                              CustomRouter.push(context: context, page: CreateNoteView());
                              value.editNote(index: i, note: note);
                              log('editNote()----------->');
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                value.deleteNote(index: i);
                              },
                            ),
                          );
                        },
                      ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
