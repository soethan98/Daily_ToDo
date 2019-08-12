import 'package:flutter/material.dart';
import 'package:flutter_todo/model/date_model.dart';
import 'package:intl/intl.dart';

class WeekCalender extends StatefulWidget {
  final ValueChanged<Map> onChanged;

  const WeekCalender({Key key, this.onChanged}) : super(key: key);
  @override
  _WeekCalenderState createState() => _WeekCalenderState();
}

class _WeekCalenderState extends State<WeekCalender> {
  Map<String, DateTime> _dateTime = new Map();

  DateTime clockTime = DateTime.now();

  List<DateModel> dateList = new List<DateModel>();

  @override
  void initState() {
    super.initState();

    var now = clockTime;

    var today = new DateTime(now.year, now.month, now.day);
    var today_1 = new DateTime(now.year, now.month, now.day + 1);
    var today_2 = new DateTime(now.year, now.month, now.day + 2);
    var today_3 = new DateTime(now.year, now.month, now.day + 3);
    var today_4 = new DateTime(now.year, now.month, now.day + 4);
    var today_5 = new DateTime(now.year, now.month, now.day + 5);
    var today_6 = new DateTime(now.year, now.month, now.day + 6);

    dateList.add(DateModel(true, today));
    dateList.add(DateModel(false, today_1));
    dateList.add(DateModel(false, today_2));
    dateList.add(DateModel(false, today_3));
    dateList.add(DateModel(false, today_4));
    dateList.add(DateModel(false, today_5));
    dateList.add(DateModel(false, today_6));
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      child: Container(
        child: _sevenDay(),
      ),
    );
  }

  Widget _sevenDay() {
    return Container(
      height: 90.0,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        scrollDirection: Axis.horizontal,
        itemCount: dateList.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            onTap: () {
              //print("Click on ${dateList[index].dateTime}");

              setState(() {
                dateList.forEach((element) => element.isSelected = false);
                dateList[index].isSelected = true;
                _dateTime['date'] = dateList[index].dateTime;
              });
            },
            child: new DateItem(dateList[index],context),
          );
        },
      ),
    );
  }
}

class DateItem extends StatelessWidget {
  final DateModel _item;
  final BuildContext context;
  DateItem(this._item,this.context);

  _dateItem(DateModel _item) {
    DateTime dateTime = _item.dateTime;
    return Card(
      color: _item.isSelected ? Theme.of(context).accentColor: Colors.white,
      child: Container(
        color: _item.isSelected ?Theme.of(context).accentColor : Colors.white,
        margin: EdgeInsets.all(8.0),
        alignment: Alignment.topCenter,
        height: 100.0,
        width: 100.0,
        child: Column(
          children: <Widget>[
            Text(
              DateFormat.LLLL().format(dateTime),
              style: TextStyle(
                  color: _item.isSelected ? Colors.white : Colors.blueGrey),
            ),
            Text(dateTime.day.toString(),
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: _item.isSelected ? Colors.white : Colors.blueGrey)),
            Text(
              DateFormat.EEEE().format(dateTime),
              style: TextStyle(
                  color: _item.isSelected ? Colors.white : Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _dateItem(_item);
  }
}
