import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/weather_viewmodel.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dayOfWeek = DateFormat('EEEE').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherViewModel>(context, listen: false).fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherViewModel>(context);
    final size = MediaQuery.of(context).size;
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
          splashRadius: 24,
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 24,
            onPressed: () => Navigator,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  weatherProvider.main?.toUpperCase() ?? 'Loading...',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  height: 200,
                  width: 200,
                  child: weatherProvider.loadingStatus == LoadingStatus.idle
                      ? CircularProgressIndicator()
                      : Image.asset(
                          "assets/icon_weather/${weatherProvider.icon}.png",
                        ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: double.infinity,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${weatherProvider.temp?.round() ?? 0}",
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
                        ),
                        // SizedBox(
                        //   width: 15,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Details".toUpperCase(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
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
                                          '${weatherProvider.feelsLike?.round() ?? 0}°'),
                                      _detailData(
                                          '${weatherProvider.humidity?.round() ?? 0}%'),
                                      _detailData(
                                          '${weatherProvider.wind ?? 0} Km/h'),
                                      _detailData(
                                          '${weatherProvider.visibility != null ? weatherProvider.visibility! / 1000 : 00} km'),
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
                Container(
                  height: size.height * 0.1,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      dayOfWeek,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 2,
                  color: Colors.grey,
                ),
                Container(
                  height: size.height * 0.1,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      partOfDay(),
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 40,
                      ),
                    ),
                  ),
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

  String partOfDay() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
