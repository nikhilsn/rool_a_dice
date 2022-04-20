import 'package:flutter/cupertino.dart';

enum Environments { DEV, PROD }

class AppConfig extends InheritedWidget {
  AppConfig({this.appDisplayName,this.environment,
    Widget? child}):super(child: child!);

  final String? appDisplayName;
  final Environments? environment;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

}