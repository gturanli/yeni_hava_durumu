import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:yeni_hava_durumu/home_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String sehir = 'Ankara';
  var sicaklik;
  var locationData;
  var woeid;

  Future<void> getLocationTemperature() async {
    var response = await http
        .get(Uri.parse('https://www.metaweather.com/api/location/$woeid/'));

    var temperatureDataParsed = jsonDecode(response.body);
    //sicaklik =temperatureDataParsed['consolidated_weather'][0]['the_temp'];

    setState(() {
      sicaklik =
          temperatureDataParsed['consolidated_weather'][0]['the_temp'].round();
      print('setState çağrıldı');
    });
  }

  Future<void> getLocationData() async {
    locationData = await http.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?query=$sehir'));
    var locationDataParsed = jsonDecode(locationData.body);
    woeid = locationDataParsed[0]['woeid'];
  }

  void getDataFromApi() async {
    await getLocationData();
    getLocationTemperature();
  }

  @override
  void initState() {
    getDataFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/c.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  '$sicaklik',
                  style: TextStyle(
                    fontSize: 70,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('$sehir',
                      style: TextStyle(
                        fontSize: 60,
                      )),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      sehir = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                      getDataFromApi();
                      setState(() {
                        sehir = sehir;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
