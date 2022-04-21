import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/resources/constants.dart';
import 'package:roll_a_dice/resources/environment_constants.dart';
import 'package:roll_a_dice/services/authentication/firebase_user_stream.dart';
import 'package:roll_a_dice/services/leaderboard_stream/leaderboard_stream.dart';
import 'package:roll_a_dice/ui/screens/authentication/singin_screen.dart';
import 'package:roll_a_dice/ui/screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appConfig = AppConfig(
    appDisplayName: Constants.appName,
    environment: Environments.DEV,
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LeaderBoardProvider()),
      ],
      child: MyApp(),
    ),
  );

  runApp(appConfig);
}

class MyApp extends StatelessWidget {
  final FirebaseUserStream _userStream = FirebaseUserStream();

  @override
  Widget build(BuildContext context) {
    var _appConfig = AppConfig.of(context);
    _userStream.listen();

    return MaterialApp(
      title: _appConfig!.appDisplayName!,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: StreamBuilder<bool>(
          stream: _userStream.userStream,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!) {
                return HomeScreen();
              } else {
                return const SinginScreen();
              }
            }
            return Container(
              color: Colors.brown,
            );
          }),
    );
  }
}
