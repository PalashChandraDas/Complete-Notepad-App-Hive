import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/note.dart';

class NoteProvider extends ChangeNotifier {
  late Box<Note> _noteBox;
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  int? _selectedIndex;

  // Like onInit()
  // Default constructor
  NoteProvider() {
    _init();
    log('onInit() called--------------');
  }

  Future<void> _init() async {
    _noteBox = Hive.box<Note>('notes');
    notifyListeners();
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
  void notify() => notifyListeners();

  ////////-------DELETE NOTE------------///////
  ///////-------///////////////////
  List<bool> selectedNotes = [];
  bool isToggleVisible = false;
  bool isSelectedPermission = false;
  toggleVisibility(){
    isToggleVisible = true;
    notifyListeners();
  }
  selectedPermission(){
    isSelectedPermission = !isSelectedPermission;
    notifyListeners();
  }
  selectedToggle({required int index}){
    selectedNotes[index] = !selectedNotes[index];
    notifyListeners();
  }

  void toggleSelectAll({required Box<Note> noteBox, required bool selectAll}) {
    log('toggleSelectAll() called--------------');

      selectedNotes = List.generate(noteBox.length, (index) => selectAll);
      notifyListeners();
      log('Note select all successfully--------------');

  }

  void deleteSelectedNotes(Box<Note> noteBox) {
    log('deleteSelectedNotes() called--------------');
    for (int i = selectedNotes.length - 1; i >= 0; i--) {
      if (selectedNotes[i]) {
        noteBox.deleteAt(i);
        selectedNotes.removeAt(i);
        log('Note deleted successfully--------------');
        isToggleVisible = false;
      }
    }
    notifyListeners();
  }

  Future<bool>exitApp() async{
    if(isToggleVisible == true){
      isToggleVisible = false;
      notifyListeners();
      log('toggleVisible: FALSE++++++');
      return false;
    } else{
      log('app exit successfully!!');
      return true;
    }

  }

//------
}
