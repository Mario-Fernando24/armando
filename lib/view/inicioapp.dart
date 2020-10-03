import 'package:flutter/material.dart';
import 'package:startogodomiciliario/view/screens/onboarding_screen.dart';

class MarioPru extends StatefulWidget {
  @override
  _MarioPruState createState() => _MarioPruState();
}

class _MarioPruState extends State<MarioPru> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startogo Driver',
      debugShowCheckedModeBanner: false,
      //llamo la funcion donde esta style e imagen del inicio de la aplicacion cuando instalo la apk
      home: OnboardingScreen(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
