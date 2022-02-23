import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/city/city_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/bloc/weather/weather_status.dart';
import 'package:weather_app/repo/weather_repo.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dayOfWeek = DateFormat('EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final cityInfo = ModalRoute.of(context)!.settings.arguments as CityState;
    print(cityInfo.toString());
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => WeatherBloc(context.read<WeatherRepo>())
        ..add(FetchWeatherData(cityInfo.cityName, cityInfo.lat, cityInfo.lon)),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return Text(
                state.cityName.toUpperCase(),
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 22,
                ),
              );
            },
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
              onPressed: () => Navigator.restorablePushNamed((context), '/',
                  arguments: true),
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<WeatherBloc>().add(RefreshWeather()),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                      height: size.height,
                      width: double.infinity,
                      child: Column(
                        children: [
                          BlocBuilder<WeatherBloc, WeatherState>(
                            builder: (context, state) {
                              return Text(
                                state.main?.toUpperCase() ?? 'Loading...',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 40,
                                ),
                              );
                            },
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            height: 200,
                            width: 200,
                            child: BlocBuilder<WeatherBloc, WeatherState>(
                              builder: (context, state) {
                                if (state.weatherStatus is WeatherIsLoading)
                                  return CircularProgressIndicator();
                                else if (state.weatherStatus is WeatherLoaded)
                                  return Image.asset(
                                    "assets/icon_weather/${state.icon}.png",
                                  );
                                else
                                  return Icon(Icons.error);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            width: double.infinity,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BlocBuilder<WeatherBloc, WeatherState>(
                                          builder: (context, state) {
                                            return Text(
                                              "${state.temp?.round() ?? 0}",
                                              style: TextStyle(
                                                fontSize: 70,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.start,
                                            );
                                          },
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            BlocBuilder<WeatherBloc,
                                                WeatherState>(
                                              builder: (context, state) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _detailData(
                                                        '${state.feelsLike?.round() ?? 0}°'),
                                                    _detailData(
                                                        '${state.humidity?.round() ?? 0}%'),
                                                    _detailData(
                                                        '${state.wind ?? 0} Km/h'),
                                                    _detailData(
                                                        '${state.visibility != null ? state.visibility! / 1000 : 00} km'),
                                                  ],
                                                );
                                              },
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
              ),
            );
          },
        ),
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
