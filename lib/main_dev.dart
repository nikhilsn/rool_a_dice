import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/resources/constants.dart';
import 'package:roll_a_dice/resources/environment_constants.dart';
import 'package:roll_a_dice/services/authentication/user_profile.dart';
import 'package:roll_a_dice/services/leaderboard_stream/leaderboard_stream.dart';

import 'main.dart';

//Entrypoint for the application in Development
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appConfig = AppConfig(
    appDisplayName: Constants.devAppName,
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
