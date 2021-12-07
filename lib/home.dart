import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';

class myOldPage extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: Text('WeatherApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Exter the city you want to Search',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 200,
              child: TextField(
                maxLines: 4,
                controller: textEditingController,
                onSubmitted: (string) {
                  // Navigator.of(context).push(MaterialPageRoute(
                  // builder: (_) => MyHomePage(textEditingController.text)));
                },
                onChanged: (string) {
                  textEditingController.text = string;
                },
                keyboardType: TextInputType.multiline,
              ),
            )
          ],
        ),
      ),
    );
  }
}
