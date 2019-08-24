import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shape: RoundedRectangleBorder(),
      elevation: 5.0,

      backgroundColor: Theme.of(context).backgroundColor,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      width: 150.0,
      height: 320.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/boy128.png'),
              minRadius: 20.0,
              maxRadius: 50.0,
              backgroundColor: Theme.of(context).accentColor,

            ),
//            child: CachedNetworkImage(
//              imageUrl: 'https://randomuser.me/api/portraits/men/35.jpg',
//              imageBuilder: (context, imageProvider) {
//                return Container(
//                  width: 100.0,
//                  height: 100.0,
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: imageProvider,
//                      fit: BoxFit.fill,
//                    ),
//                    shape: BoxShape.circle,
//                  ),
//                );
//              },
//            ),
          ),
          SizedBox(height: 16.0),
          Text('Soe Than',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400)),
          SizedBox(height: 8.0),
          Text('Android Developer', style: TextStyle(fontSize: 18.0)),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.link,
                size: 15.0,
              ),
              SizedBox(width: 4.0),
              GestureDetector(
                onTap: () => launch('https://soethan98.github.io'),
                child: Text(
                  'https://soethan98.github.io',
                  style: TextStyle(
                      fontSize: 18.0,
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).accentColor),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.facebook,
                  size: 30.0,
                ),
                onPressed: () =>
                    launch('https://www.facebook.com/soe.than.9634'),
              ),
              SizedBox(width: 22.0),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.github,
                  size: 30.0,
                ),
                onPressed: () => launch('https://github.com/soethan98'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
