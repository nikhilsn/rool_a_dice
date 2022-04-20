import 'package:flutter/material.dart';
import 'package:roll_a_dice/resources/constants.dart';
import 'package:roll_a_dice/resources/environment_constants.dart';

import 'main.dart';

//Entrypoint for the application in Production
void main() {
  final appConfig = AppConfig(appDisplayName: Constants.appName,
    environment: Environments.PROD,
    child: MyApp(),);

  runApp(appConfig);
}
