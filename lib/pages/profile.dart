import 'package:flutter/material.dart';
import 'package:flutter_todo/utils/consts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(),
      elevation: 5.0,
      backgroundColor: Theme.of(context).backgroundColor,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 50.0,
          // backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/35.jpg'),

          child: CachedNetworkImage(
            fit: BoxFit.cover,
            
            
            imageUrl: 'https://randomuser.me/api/portraits/men/35.jpg',
          ),
        )
      ],
    );
  }
}
