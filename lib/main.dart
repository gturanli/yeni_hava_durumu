import 'package:flutter/material.dart';
import 'package:yeni_hava_durumu/weather_page.dart';
import 'home_page.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HAVA DURUMU',
      color: Colors.white,
      home: WeatherPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
