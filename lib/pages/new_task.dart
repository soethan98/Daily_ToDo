import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo/utils/database_helper.dart';
import 'package:flutter_todo/model/note.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  final Note note;
  final String appbarTitle;

  NewTask(this.note, this.appbarTitle);
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  static var _priorities = ['High', 'Medium', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  final dateFormat = DateFormat("EEEE, d");
  final timeFormat = DateFormat.jm();

  var _dateInfo;
  var _timeInfo;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateInfo = dateFormat.format(DateTime.now());
    _timeInfo = timeFormat.format(DateTime.now());
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; // 'High'
        break;
      case 2:
        priority = _priorities[1]; // 'Medium'
        break;
      case 3:
        priority = _priorities[2]; //'Low'
        break;
    }
    return priority;
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        widget.note.priority = 1;
        break;
      case 'Medium':
        widget.note.priority = 2;
        break;
      case 'Low':
        widget.note.priority = 3;
        break;
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _save() async {
    debugPrint('First Step');

    moveToLastScreen();
    widget.note.date = DateTime.now().millisecondsSinceEpoch;
    int result;
    if (widget.note.id != null) {
      // Case 1: Update operation
      // result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(widget.note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void updateTitle() {
    widget.note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    widget.note.description = descriptionController.text;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Task'),
        elevation: 0.0,
      ),
      body: ListView(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Card(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            elevation: 5.0,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0, left: 6.0, right: 6.0),
                  child: TextField(
                    onChanged: (value) {
                      updateTitle();
                    },
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 3, color: Theme.of(context).accentColor)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).accentColor),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 6.0, right: 6.0),
                  child: TextField(
                    maxLines: 5,
                    onChanged: (value) {
                      updateDescription();
                    },
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 3, color: Theme.of(context).accentColor)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).accentColor),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Priority : ',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      DropdownButton(
                          items: _priorities.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          style: textStyle,
                          value: getPriorityAsString(widget.note.priority),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              updatePriorityAsInt(valueSelectedByUser);
                              debugPrint('User selected $valueSelectedByUser');
                            });
                          })
                    ],
                  ),
                ),
                Text(
                  'Complete By',
                  style: TextStyle(fontSize: 16.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () async {
                        var _selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2018),
                          lastDate: DateTime(2030),
                        );

                        if (_selectedDate != null) {
                          setState(() {
                            _dateInfo = dateFormat.format(_selectedDate);
                          });
                        }
                      },
                    ),
                    SizedBox(width: 5.0),
                    Text('$_dateInfo', style: textStyle)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.timer,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () async {
                              var _selectedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context);
                              if (_selectedTime != null) {
                                setState(() {
                                  // DateTime()
                                  _timeInfo = _selectedTime.format(context);
                                });
                              }
                            },
                          ),
                          Text('$_timeInfo',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Text('Notification:', style: textStyle),
                          SizedBox(width: 5.0),
                          Switch(
                            onChanged: (bool value) {
                              // _onChanged1(value);
                            },
                            activeColor: Theme.of(context).accentColor,
                            dragStartBehavior: DragStartBehavior.start,
                            value: false,
                          )
                        ],
                      ),
                    )

                    // Text('Alarm:', style: textStyle),
                  ],
                ),
              ],
            )),
        SizedBox(
          height: 16.0,
        ),
        Container(
          margin: EdgeInsets.only(right: 8.0, left: 8.0),
          child: RaisedButton(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            onPressed: () {
              _save();
            },
            elevation: 5.0,
            textColor: Colors.white,
            color: Theme.of(context).accentColor,
            child: Text('Add Task'),
          ),
        )
      ]),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
