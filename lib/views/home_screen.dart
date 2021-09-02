import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/weather_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherViewModel>(context, listen: false).fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Da Nang".toUpperCase(),
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.black,
            size: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            child: Column(
              children: [
                Text(
                  weatherProvider.main.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 25,
                  ),
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    "assets/icon_weather/${weatherProvider.icon}.png",
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: double.infinity,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${weatherProvider.temp.round()}",
                                  style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "0",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                ),
                                Text(
                                  "${weatherProvider.tempMin.round()}°",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_upward,
                                ),
                                Text(
                                  "${weatherProvider.tempMax.round()}°",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Details".toUpperCase(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  letterSpacing: 3,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _detailLabel('Feels like'),
                                      _detailLabel('humidity'),
                                      _detailLabel('wind'),
                                      _detailLabel('visibility'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _detailData(
                                          '${weatherProvider.feelsLike.round()}°'),
                                      _detailData(
                                          '${weatherProvider.humidity.round()}%'),
                                      _detailData(
                                          '${weatherProvider.wind} Km/h'),
                                      _detailData(
                                          '${weatherProvider.visibility / 1000} km'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 2,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.montserrat(
          fontSize: 13,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _detailData(String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        data,
        style: GoogleFonts.montserrat(
          fontSize: 13,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
