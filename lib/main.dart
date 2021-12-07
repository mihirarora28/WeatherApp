import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}

Future<Map<String, dynamic>> fetchdata() async {
  final cityName = "gurgaon";
  final ApiKey = "1e79360f468ad279692d726c7fa72261";
  final Url =
      "http://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=1e79360f468ad279692d726c7fa72261";

  Response response = await get(Uri.parse(Url));
  if (response.statusCode == 200) {
    return (jsonDecode(response.body));
  } else {
    throw Exception("Error in loading Your Request");
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future? data;
  var temperature = 12.1;
  var weather = '1';
  var humidity = 41;
  var windspeed = 12.1;
  var lowof = 12.1;
  var highof = 12.1;
  var name = 'gurgaon';
  bool seen = true;
  @override
  void initState() {
    data = fetchdata();
    data?.then((value) {
      temperature = value['main']['temp'] - 273;
      weather = value['weather'][0]['main'];
      humidity = value['main']['humidity'];
      windspeed = value['wind']['speed'];
      lowof = value['main']['temp_min'] - 273;
      highof = value['main']['temp_max'] - 273;
      setState(() {
        seen = false;
      });

      name = value['name'];

      // print(temperature);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: Text('WeatherApp'),
      ),
      body: seen == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xfff1f1f1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name.toString(),
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            temperature.toStringAsFixed(2) + '°',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'High of ${highof.toStringAsFixed(2)} , Low of ${lowof.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.thermostat,
                            color: Colors.purple,
                          ),
                          title: Text('Temperature'),
                          subtitle: Text(temperature.toStringAsFixed(2)),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.cloud,
                            color: Colors.purple,
                          ),
                          title: Text('Weather'),
                          subtitle: Text(weather.toString()),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.wb_sunny,
                            color: Colors.purple,
                          ),
                          title: Text('Humidity'),
                          subtitle: Text(humidity.toString()),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.waves,
                            color: Colors.purple,
                          ),
                          title: Text('Wind Speed'),
                          subtitle: Text(windspeed.toString()),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
