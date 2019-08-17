import 'package:flutter/material.dart';
import 'package:flutter_todo/custom/week_calender.dart';
import 'package:flutter_todo/model/note.dart';
import 'package:flutter_todo/utils/database_helper.dart';

class UpdateNote {
  final Note note;
  final BuildContext context;
  DateTime selectDate;
  TimeOfDay selectTime;

  UpdateNote(this.note, this.context);

  DatabaseHelper helper = DatabaseHelper();

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void save() async {
    debugPrint('Complete:${note.date}');

    moveToLastScreen();
    // // note.date = DateTime.now().millisecondsSinceEpoch;
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void updateTitle(String title) {
    note.title = title;
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Medium':
        note.priority = 2;
        break;
      case 'Low':
        note.priority = 3;
        break;
    }
  }

  // Update the description of Note object
  void updateDescription(String description) {
    note.description = description;
  }

  void updateDateTime(var _selectDate, var _selectTime) {
    note.specificDate =
        DateTime(_selectDate.year, _selectDate.month, _selectDate.day)
            .millisecondsSinceEpoch;
    note.date = DateTime(_selectDate.year, _selectDate.month, _selectDate.day,
            _selectTime.hour, _selectTime.minute)
        .millisecondsSinceEpoch;
  }

  void updateAlarmSwitch(bool value) {
    switch (value) {
      case true:
        note.alarm = 1;
        break;
      case false:
        note.alarm = 0;
        break;
    }
  }

  void delete() async {
    moveToLastScreen();

    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }
}
