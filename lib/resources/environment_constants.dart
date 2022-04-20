enum Environments { DEV, PROD }

class AppEnvironment {
  late Environments _env;

  set setAppEnvironment(Environments env) {
    _env = env;
  }

  get getAppEnvironment => _env;
}
