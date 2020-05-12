import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';
import 'package:Weather/widgets/image_icon.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _time = DateFormat('jm').format(DateTime.now()).toString();
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(minutes: 1), (Timer t) => getTime());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: result,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.lightBlue,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          _time,
                          // DateFormat.HOUR24_MINUTE.format(DateTime.now()).toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 25.0,
                          )
                        )
                      ),
                      SizedBox(
                        height: 30.0
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data['name'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 10.0
                              ),
                              Text(
                                ((double.parse(snapshot.data['main']['temp'].toString()) - 273.15).toStringAsFixed(2)) + '\u00B0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 55.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif', 
                                image: 'http://openweathermap.org/img/wn/' + snapshot.data['weather'][0]['icon'].toString() + '@2x.png',
                                width: 100.0
                              ),
                              Text(
                                snapshot.data['weather'][0]['description'].toString(),
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14.0,
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 190.0,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                width: 100.0,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Text(
                                      'Humidity',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 25.0
                                    ),
                                    Text(
                                      snapshot.data['main']['humidity'].toString() + '%',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15.0
                              ),
                              Container(
                                width: 100.0,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Text(
                                      'Min. Temp.',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 25.0
                                    ),
                                    Text(
                                      (double.parse(snapshot.data['main']['temp_min'].toString()) - 273.15).toStringAsFixed(2) + '\u00B0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15.0
                              ),
                              Container(
                                width: 100.0,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Text(
                                      'Feels Like',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 25.0
                                    ),
                                    Text(
                                      (double.parse(snapshot.data['main']['feels_like'].toString()) - 273.15).toStringAsFixed(2) + '\u00B0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15.0
                              ),
                              Container(
                                width: 100.0,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Text(
                                      'Max. Temp.',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 25.0
                                    ),
                                    Text(
                                      (double.parse(snapshot.data['main']['temp_max'].toString()) - 273.15).toStringAsFixed(2) + '\u00B0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Container(
                                width: 100.0,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Text(
                                      'Clouds',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 25.0
                                    ),
                                    Text(
                                      snapshot.data['clouds']['all'].toString() + '%',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Container(
                                width: 100.0,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Text(
                                      'Pressure/hPa',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 25.0
                                    ),
                                    Text(
                                      snapshot.data['main']['pressure'].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0
                      ),
                      Center(
                        child: Text(
                          snapshot.data['sys']['country'].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 90.0,
                          ),
                        )
                      ),
                      SizedBox(
                        height: 20.0
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.wb_sunny,
                                size: 50.0,
                                color: Colors.yellow,
                              ),
                              Text(
                                'Sunrise',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0
                              ),
                              Text(
                                DateFormat('jm').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(snapshot.data['sys']['sunset'].toString()))).toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.toll,
                                size: 50.0,
                                color: Colors.orange[800],
                              ),
                              Text(
                                'Sunset',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0
                              ),
                              Text(
                                DateFormat('jm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(snapshot.data['sys']['sunset'].toString()))).toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                )
              )
            ),
          );
        }
      },
    );
  }

  Future<dynamic> get result async {
    if (await Geolocator().isLocationServiceEnabled()) {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Response response = await get('https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=fa97471db93e4642afaae43c15d860cf');
      return json.decode(response.body);
    }

    Toast.show('Location Service is Off. Please turn it On', context, duration: 5);
    
  }

  void getTime() {
    setState(() {
      _time = DateFormat('jm').format(DateTime.now()).toString();
    });
  }
}