import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/note.dart';

class NoteProvider extends ChangeNotifier {
  late Box<Note> _noteBox;
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  int? _selectedIndex;

  // Like onInit()
  // Default constructor
  NoteProvider() {
    _noteBox = Hive.box<Note>('notes');
    log('onInit() called--------------');
  }

  Box<Note> get noteBox => _noteBox;
  int? get selectedIndex => _selectedIndex;

  void addNote() {
    log('addNote() called--------------');
    final title = titleCtrl.text;
    final content = descriptionCtrl.text;

    if (title.isNotEmpty || content.isNotEmpty) {
      Note newNote = Note(title, content);
      _noteBox.add(newNote);
      clearFields();
      notifyListeners(); // Refresh the UI
      log('note added--------------');
    }
  }

  void updateNote() {
    log('updateNote called--------------');
    if (_selectedIndex != null) {
      final title = titleCtrl.text;
      final content = descriptionCtrl.text;

      if (title.isNotEmpty || content.isNotEmpty) {
        Note updatedNote = _noteBox.getAt(_selectedIndex!)!;
        updatedNote.title = title;
        updatedNote.content = content;
        updatedNote.save();
        clearSelection();
        notifyListeners(); // Refresh the UI
        log('note saved--------------');
      }
    }
  }

  void deleteNote({required int index}) {
    log('deleteNote() called--------------');
    _noteBox.deleteAt(index);
    clearSelection();
    notifyListeners(); // Refresh the UI
    log('note deleted--------------');
  }

  void editNote({required int index, required Note note}) {
    log('editNote called--------------');
    _selectedIndex = index;
    titleCtrl.text = note.title!;
    descriptionCtrl.text = note.content!;
    notifyListeners(); // Refresh the UI
  }

  void clearSelection() {
    _selectedIndex = null;
    clearFields();
    notifyListeners(); // Refresh the UI
  }

  void clearFields() {
    titleCtrl.clear();
    descriptionCtrl.clear();
  }
}
