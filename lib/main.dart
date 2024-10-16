import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Importe suas telas aqui

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Defina sua tela inicial aqui
    );
  }
}
