import 'package:carproject/screens/check_in_screen.dart';
import 'package:carproject/screens/check_out_screen.dart';
import 'package:carproject/screens/home_screen.dart';
import 'package:carproject/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'models/car.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the application documents directory
  final dir = await getApplicationDocumentsDirectory();

  // Open the Isar database with the specified directory
  final isar = await Isar.open(
    [CarSchema],
    directory: dir.path,
  );

  runApp(MyApp(isar));
}

class MyApp extends StatelessWidget {
  final Isar isar;

  MyApp(this.isar);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Car Check-in System',
      home: SplashScreen(),
      routes: {
        '/checked_out': (context) => CheckedOutCarsScreen(),
      },
    );
  }
}
