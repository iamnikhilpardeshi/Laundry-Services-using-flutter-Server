import 'package:flutter/material.dart';
import 'home_tabs.dart';
import 'package:flutter/services.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations
  ([DeviceOrientation.portraitUp]);
  return runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Server App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabbedAppBar(),
    );
  }
}

