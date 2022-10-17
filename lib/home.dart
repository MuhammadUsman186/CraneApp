import 'package:crane_master/theme/theme.dart';
import 'package:crane_master/ui/backdrop.dart';
import 'package:crane_master/ui/eat_form.dart';
import 'package:crane_master/ui/fly_form.dart';
import 'package:crane_master/ui/sleep_form.dart';
import 'package:flutter/material.dart';

class Crane extends StatefulWidget {
  const Crane({Key key}) : super(key: key);

  @override
  State<Crane> createState() => _CraneState();
}

class _CraneState extends State<Crane> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crane',
      debugShowCheckedModeBanner: false,
      home: BackDrop(
        frontLayer: Container(),
        backLayer: <Widget>[
          FlyForm(),
          SleepForm(),
          EatForm(),
        ],
        frontTitle: Text('CRANE'),
        backTitle: Text('MENU'),
      ),
      initialRoute: '/',
      onGenerateRoute: _getRoute,
      theme: kCraneTheme,
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name != '/') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => Crane(),
    fullscreenDialog: true,
  );
}
