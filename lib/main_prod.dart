import 'package:roll_a_dice/resources/environment_constants.dart';

import 'main.dart';

//Entrypoint for the application in Production
void main() {
  AppEnvironment().setAppEnvironment = Environments.PROD;
  mainDelegate();
}
