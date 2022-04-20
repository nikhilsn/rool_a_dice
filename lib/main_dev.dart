import 'package:roll_a_dice/resources/environment_constants.dart';

import 'main.dart';

//Entrypoint for the application in Development
void main() {
  AppEnvironment().setAppEnvironment = Environments.DEV;
  mainDelegate();
}
