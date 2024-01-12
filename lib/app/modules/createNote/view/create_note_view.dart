import 'package:flutter/material.dart';
import 'package:note_pad_hive/utils/custom_strings.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_constant.dart';
import '../../note/provider/note_provider.dart';
import '../widgets/k_description_field.dart';
import '../widgets/k_title_field.dart';

class CreateNoteView extends StatelessWidget {
  const CreateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    //instance
    final notepadProvider = context.read<NoteProvider>();
    return WillPopScope(
      onWillPop: () async {
        notepadProvider.selectedIndex == null
            ? notepadProvider.addNote()
            : notepadProvider.updateNote(context: context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text(CustomStrings.createNoteTitle),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                notepadProvider.selectedIndex == null
                    ? notepadProvider.addNote()
                    : notepadProvider.updateNote(context: context);
              },
              icon: const Icon(Icons.check),
            )
          ],),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              KTitleField(controller: notepadProvider.titleCtrl),
              AppConstant.kDefaultGap,
              KDescriptionField(controller: notepadProvider.descriptionCtrl)
            ],
          ),
        ),
      ),
    );
  }
}
