import 'package:flutter/material.dart';


class ListHeader extends StatelessWidget {
  final String listHeader;
  const ListHeader({Key key, this.listHeader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 14.0),
      child: Align(
        alignment: FractionalOffset.topLeft,
        child: Text('$listHeader',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
