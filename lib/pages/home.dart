import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'new_task.dart';
import 'package:flutter_todo/model/note.dart';
import 'package:flutter_todo/utils/database_helper.dart';
import 'package:flutter_todo/custom/week_calender.dart';
import 'package:flutter_todo/utils/_diamond_border.dart';
import 'package:flutter_todo/custom/list_header.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

Color getPriorityColor(int priority) {
  switch (priority) {
    case 1:
      return Colors.red;
      break;
    case 2:
      return Colors.yellow;
      break;
    case 3:
      return Colors.green;
      break;

    default:
      return Colors.yellow;
  }
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  DateTime _clickedDate = DateTime.now();


  // AssetImage assetImage = AssetImage('images/leisure.png');

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      if (_clickedDate != null) {
        Future<List<Note>> noteListFuture =
            databaseHelper.getNoteListFromMillisecond(DateTime(
                    _clickedDate.year, _clickedDate.month, _clickedDate.day)
                .millisecondsSinceEpoch);

        noteListFuture.then((noteList) {
          for(var note in noteList){
            debugPrint('${note.id}');
          }
          setState(() {
            this.noteList = noteList;

            this.count = noteList.length;
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    databaseHelper.getCount().then((i){
      debugPrint('Count: $i');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.light,
        elevation: 0.0,
        title: Text(
          'ToDo',
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Settings();
              }));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              WeekCalender(
                onChanged: (_dateTime) {
                  _dateTime.forEach((k, v) {
                    setState(() {
                      _clickedDate = v;
                      updateListView();
                    });
                  });
                },
              ),
              count > 0
                  ? ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        ListHeader(listHeader: 'Pending Tasks'),
                        ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: count,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.all(12.0),
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[700],
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipOval(
                                        child: Material(
                                          color: getPriorityColor(this
                                              .noteList[index]
                                              .priority), // button color
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: SizedBox(
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle:
                                      Text('${noteList[index].description}'),
                                  title: Text('${noteList[index].title}'),
                                  trailing: IconButton(
                                    onPressed: () {
                                      navigateToDetail(
                                          noteList[index], 'Update Task');
                                    },
                                    icon: Icon(
                                      Icons.navigate_next,
                                      size: 38.0,
                                    ),
                                  ),
                                ),
                              );
                            }),
                        ListHeader(listHeader: 'Done Tasks'),
                        ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: count,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.all(12.0),
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[700],
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipOval(
                                        child: Material(
                                          color: getPriorityColor(this
                                              .noteList[index]
                                              .priority), // button color
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: SizedBox(
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle:
                                      Text('${noteList[index].description}'),
                                  title: Text('${noteList[index].title}'),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.navigate_next,
                                      size: 38.0,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    )
                  : new Container(
                      margin: EdgeInsets.symmetric(vertical: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/leisure128.png'),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Take Rest.",
                            style: TextStyle(
                                fontSize: 24.0,
                                fontFamily: 'IndieFlower',
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "You don't have any task.",
                            style: TextStyle(
                                fontSize: 22.0,
                                fontFamily: 'IndieFlower',
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(
              Note('', '', DateTime.now().millisecondsSinceEpoch, 0, 2,
                  DateTime.now().millisecondsSinceEpoch),
              'Add Note');
        },
        child: Icon(Icons.add),
        shape: DiamondBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewTask(note, title);
    }));

    if (result == true) {
      // setState(() {
      //   count = noteList.length;
      // });
      updateListView();
    }
  }
}
