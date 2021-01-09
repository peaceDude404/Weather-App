import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(
  MaterialApp(
    title: 'Weather App',
    home: Home(),
  )
);

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
}
}
class _HomeState extends State<Home> {

  var temp;
  var humidity;
  var weather;
  var windspeed;

  Future getdata() async {
    http.Response response = await http.get('http://api.openweathermap.org/data/2.5/weather?q=Kanpur&appid=3910c7973e0fe161819b7b0a01eae387');
    var result = jsonDecode(response.body);
    setState((){
      this.temp= result['main']['temp']-273;
      temp=temp.toInt();
      this.humidity= result['main']['humidity'];
      this.windspeed= result['wind']['speed'];
      this.weather=result['weather'][0]['description'];
    });
  }

  @override
  void initState()
  {
    super.initState();
    this.getdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(child: new Text('WEATHER APP')),
      ),
      //backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: new Column(
          children: [
            Container(
              // height: 200,
              child: new Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10,top: 10),
                    child: Text('KANPUR',style: new TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white60),),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: new Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Center(child: new Text('${temp.toString()}\u2103',style: new TextStyle(fontSize: 60,fontWeight: FontWeight.bold,color: Colors.white60),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(child: new Text(weather.toString(),style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.white60),)),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50,top: 150),
                        child: Center(child: new Text('Humidity',style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white60),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 110,top: 150),
                        child: Center(child: new Text('Wind Speed',style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white60),)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 70,top: 10),
                        child: Center(child: new Text(humidity.toString(),style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white60),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 163,top: 10),
                        child: Center(child: new Text(windspeed.toString(),style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white60),)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    )
    ;
  }
}