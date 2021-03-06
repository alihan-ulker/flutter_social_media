//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/pages/home_page.dart';
import 'package:social_media/pages/login_page.dart';
import 'package:social_media/services/authentication.dart';

//The page to which the user will be directed will be specified in this widget.

class Routing extends StatelessWidget {
  const Routing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authenticationService =
        Provider.of<Authentication>(context, listen: false);

    return StreamBuilder(
      stream: _authenticationService.statusTracker,
      builder: (context, snapshot) {
        //Show circular progress while waiting for connection.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        //If there is a user/client, go to the homepage.
        if (snapshot.hasData) {
          Client activeClient = snapshot.data;
          _authenticationService.activeClientId = activeClient.id;
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
