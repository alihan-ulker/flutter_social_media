//@dart=2.9
import 'package:flutter/material.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/pages/home_page.dart';
import 'package:social_media/services/authentication.dart';

//The page to which the user will be directed will be specified in this widget.

class Routing extends StatelessWidget {
  const Routing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Authentication().statusTracker,
      builder: (context, snapshot) {
        //Show circular progress while waiting for connection.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        //If there is a user/client, go to the homepage.
        if (snapshot.hasData) {
          Client activeClient = snapshot.data;
          return HomePage();
        }
      },
    );
  }
}
