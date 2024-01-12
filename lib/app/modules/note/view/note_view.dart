import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_pad_hive/app/modules/createNote/view/create_note_view.dart';
import 'package:note_pad_hive/app/modules/note/widgets/k_list_title.dart';
import 'package:note_pad_hive/app/routes/custom_router.dart';
import 'package:provider/provider.dart';

import '../../../../utils/custom_strings.dart';
import '../../../../widgets/custom_appbar.dart';
import '../model/note.dart';
import '../provider/note_provider.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    log('NoteViewBuild() called--------------');
    final noteProvider = context.read<NoteProvider>();

    return WillPopScope(
      onWillPop: () async {
        return noteProvider.exitApp();
      },
      child: Scaffold(
        appBar: const CustomAppBar(title:CustomStrings.appName),
        floatingActionButton: Consumer<NoteProvider>(
          builder: (context, value, child) {
            return FloatingActionButton(
                onPressed: () {
                  value.isToggleVisible == true
                      ? value.deleteSelectedNotes(value.noteBox)
                      : CustomRouter.push(context: context, page: const CreateNoteView());
                },
                child: Icon(value.isToggleVisible ? Icons.delete : Icons.add));
          },
        ),
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
                              title: KListTitle(text: note.title!),
                              subtitle: KListTitle(text: note.content!),
                              onTap: () {
                                if (value.isToggleVisible == true) {
                                  value.selectedToggle(index: i);
                                } else {
                                  log('route page----------->');
                                  CustomRouter.push(context: context, page: const CreateNoteView());
                                  value.editNote(index: i, note: note);
                                  log('editNote()----------->');
                                }
                              },
                              onLongPress: () {
                                if (value.isToggleVisible == false) {
                                  // Handle long press for multi-select
                                  value.toggleVisibility();
                                  value.toggleSelectAll(noteBox: value.noteBox, selectAll: false);
                                  value.selectedToggle(index: i);
                                } else {
                                  // Select or Unselect checkbox by index
                                  value.selectedToggle(index: i);
                                }
                              },
                              trailing: value.isToggleVisible
                                  ? Checkbox(
                                      value: value.selectedNotes[i],
                                      onChanged: (newValue) {
                                        value.selectedNotes[i] = newValue ?? false;
                                        value.notify();
                                        log('<<<<<<<<<<<<<<<---checkbox: $newValue');
                                      },
                                    )
                                  : const SizedBox(),
                            );
                          },
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
