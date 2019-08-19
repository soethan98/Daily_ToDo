import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo/model/note.dart';
import 'package:intl/intl.dart';
import 'package:flutter_todo/utils/update_note.dart';

class NewTask extends StatefulWidget {
  final Note note;
  final String appbarTitle;

  NewTask(this.note, this.appbarTitle);
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  static var _priorities = ['High', 'Medium', 'Low'];

  // DatabaseHelper helper = DatabaseHelper();
  UpdateNote updateNote;

  final dateFormat = DateFormat("EEEE, d");
  final timeFormat = DateFormat.jm();

  var _dateInfo;
  var _timeInfo;

  DateTime _selectDate;
  TimeOfDay _selectTime;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool _validateTitle = true;

  @override
  void initState() {
    super.initState();

    if (widget.note.date != null) {
      _dateInfo = dateFormat
          .format(DateTime.fromMillisecondsSinceEpoch(widget.note.date));
      _timeInfo = timeFormat
          .format(DateTime.fromMillisecondsSinceEpoch(widget.note.date));
    } else {
      _dateInfo = dateFormat.format(DateTime.now());
      _timeInfo = timeFormat.format(DateTime.now());
    }
    updateNote = UpdateNote(widget.note, context);
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

  void updateDateTime() {
    if (_selectDate == null) {
      _selectDate = DateTime.now();
    } else if (_selectTime == null) {
      _selectTime = TimeOfDay.now();
    }
    updateNote.updateDateTime(_selectDate, _selectTime);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;

    return WillPopScope(
      onWillPop: () async {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${widget.appbarTitle}',
            style: TextStyle(fontSize: 28.0),
          ),
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
                        updateNote.updateTitle(titleController.text);

                        setState(() {
                          _validateTitle = true;
                        });
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).accentColor)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 3, color: Theme.of(context).accentColor),
                        ),
                        errorText:
                            _validateTitle ? null : 'Please Provide Some Text',
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
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
                        debugPrint('$value');
                        updateNote
                            .updateDescription(descriptionController.text);
                      },
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).accentColor)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 3, color: Theme.of(context).accentColor),
                        ),
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
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
                                updateNote
                                    .updatePriorityAsInt(valueSelectedByUser);
                                // updatePriorityAsInt(valueSelectedByUser);
                                debugPrint(
                                    'User selected $valueSelectedByUser');
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
                              _selectDate = _selectedDate;
                              updateDateTime();
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
                              ),
                              onPressed: () async {
                                var _selectedTime = await showTimePicker(
                                    initialTime: TimeOfDay.now(),
                                    context: context);
                                if (_selectedTime != null) {
                                  setState(() {
                                    // DateTime()
                                    _selectTime = _selectedTime;
                                    updateDateTime();

                                    _timeInfo = _selectedTime.format(context);
                                  });
                                }
                              },
                            ),
                            Text('$_timeInfo',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600))
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
                                setState(() {
                                  updateNote.updateAlarmSwitch(value);
                                });
                              },
                              activeColor: Theme.of(context).accentColor,
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
                if (titleController.text.isEmpty) {
                  setState(() {
                    _validateTitle = false;
                  });
                } else {
                  setState(() {
                    _validateTitle = true;
                  });

                  if (_selectDate == null || _selectTime == null) {
                    debugPrint('Choose Time and Date');
                    return;
                  }

                  updateNote.save();
                }
              },
              elevation: 5.0,
              textColor: Colors.white,
              color: Theme.of(context).accentColor,
              child: Text('Save Task'),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            margin: EdgeInsets.only(right: 8.0, left: 8.0),
            child: RaisedButton(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              onPressed: () {
                setState(() {
                  updateNote.delete();
                });
              },
              elevation: 5.0,
              textColor: Colors.white,
              color: Colors.red,
              child: Text('Delete Task'),
            ),
          )
        ]),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
