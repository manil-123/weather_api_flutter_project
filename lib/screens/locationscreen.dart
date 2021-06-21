import 'package:flutter/material.dart';
import 'package:weatherapi/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weatherapi/widgets/extrainfo.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  int humidity;
  int pressure;
  double windSpeed;
  String weatherIcon;
  String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        humidity = 0;
        windSpeed = 0;
        pressure = 0;
        cityName = '';
        return;
      }
      dynamic temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
      dynamic humid = weatherData['main']['humidity'];
      humidity = humid.toInt();
      windSpeed = weatherData['wind']['speed'];
      dynamic press = weatherData['main']['pressure'];
      pressure = press.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('h:mma:ss   EEE d MMM').format(dateTime);
    TextEditingController myController = TextEditingController();
    Widget customSearchBar = TextField(
        controller: myController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: new TextStyle(color: Colors.white),
            hintText: 'Enter City Name'),
        style: TextStyle(
          color: Colors.white,
        ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: customSearchBar,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            var weatherData = await weather.getLocationWeather();
            updateUI(weatherData);
          },
          icon: Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              if (myController.text != null) {
                var weatherData =
                    await weather.getCityWeather(myController.text);
                updateUI(weatherData);
              }
            },
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 120.0,
                            ),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$formattedDate',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temperature\u2103',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 80,
                              ),
                            ),
                            Text(
                              weatherIcon,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 85,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ExtraInfo(
                              textFirst: 'Wind',
                              value: windSpeed,
                              textLast: 'km/hr',
                            ),
                            ExtraInfo(
                              textFirst: 'Pressure',
                              value: pressure,
                              textLast: 'Hg',
                            ),
                            ExtraInfo(
                              textFirst: 'Humidity',
                              value: humidity,
                              textLast: '%',
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
