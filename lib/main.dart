import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roll_a_dice/resources/constants.dart';
import 'package:roll_a_dice/resources/environment_constants.dart';
import 'package:roll_a_dice/services/authentication/firebase_user_stream.dart';
import 'package:roll_a_dice/ui/screens/authentication/singin_screen.dart';
import 'package:roll_a_dice/ui/screens/game_screen.dart';
import 'package:roll_a_dice/ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  final FirebaseUserStream _userStream=  FirebaseUserStream();
  @override
  Widget build(BuildContext context) {
    var _appConfig = AppConfig.of(context);
    _userStream.listen();

    return MaterialApp(
      title: _appConfig!.appDisplayName!,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      StreamBuilder<bool>(
          stream: _userStream.userStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.connectionState==ConnectionState.active) {
              if (snapshot.data!) {
                return HomeScreen();
              } else {
                return _appConfig.environment == Environments.DEV
                    ? const SinginScreen()
                    : Container();
              }
            }
            return Container(
              color: Colors.brown,
            );
          }),
    );
  }
}
