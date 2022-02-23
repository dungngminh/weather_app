import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/city/city_bloc.dart';
import 'package:weather_app/bloc/city/city_status.dart';
import 'package:weather_app/repo/geo_repo.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? isReSearch =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => CityBloc(context.read<GeoRepo>()),
          child: Column(
            children: [
              searchBar(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                ),
                child: BlocBuilder<CityBloc, CityState>(
                  builder: (context, state) {
                    if (state.cityStatus is CityIsSearching)
                      return CircularProgressIndicator();
                    else if (state.cityStatus is CitySearched)
                      return ListTile(
                        title: Text(
                          state.cityName,
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                            state.lat.toString() + " " + state.lon.toString()),
                        onTap: () => isReSearch //TODO fix route
                            ? Navigator.pushNamedAndRemoveUntil((context),
                                'weather', (Route<dynamic> route) => false,
                                arguments: state)
                            : Navigator.pushNamed((context), 'weather',
                                arguments: state),
                      );
                    else if (state.cityStatus is CitySearchedFail) {
                      return Text("Khong tim thay city");
                    } else
                      return Text("");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container searchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Color(0xFFE5E5E5),
        ),
      ),
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Icon(Icons.location_city),
          SizedBox(
            width: 30,
          ),
          Flexible(
            child: BlocBuilder<CityBloc, CityState>(
              builder: (context, state) {
                return TextField(
                  decoration: InputDecoration(
                    hintText: 'Input city name...',
                    enabledBorder: InputBorder.none,
                  ),
                  onChanged: (value) => context.read<CityBloc>().add(
                        CityNameChanged(value),
                      ),
                );
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Icon(Icons.search),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
