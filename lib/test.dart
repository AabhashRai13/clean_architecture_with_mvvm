import 'package:clean_architecture_with_mvvm/app/app.dart';
import 'package:flutter/material.dart';
 class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  void updateAppState() {
    MyApp.instance.appState = 10;
  }

  void getAppState() {
    print(MyApp.instance.appState); //10s
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
