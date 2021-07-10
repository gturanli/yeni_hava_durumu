import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yeni_hava_durumu/weather_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? secilenSehir;
  final myController = TextEditingController();
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Hata"),
          content: new Text("Lütfen şehir ismini kontorl ediniz."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CircleAvatar(
                radius: 150,
                backgroundImage: NetworkImage(
                    'https://dijitalkoleksiyon.files.wordpress.com/2012/11/globe_rotating1.gif'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(35),
              width: 400,
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Şehir Adını Giriniz',
                ),
              ),
            ),
            Container(
              width: 170,
              height: 70,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  var response = await http.get(Uri.parse(
                      'https://www.metaweather.com/api/location/search/?query=${myController.text}'));

                  jsonDecode(response.body).isEmpty
                      ? _showDialog()
                      : Navigator.pop(context, myController.text);
                },
                child: Text(
                  'şehri seç',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
