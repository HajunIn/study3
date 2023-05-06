import 'package:flutter/material.dart';
import 'package:study3/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await initializeDateFormatting();

  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}