import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(
                  0xFFE5E5E5,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.location_city),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'City',
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text('Location'),
          //       Text('Status'),
          //       Text('32 .C'),
          //       Icon(Icons.wb_sunny),
          //       Text('Date'),
          //       Text('Time'),
          //       SizedBox(
          //         height: 20,
          //       ),
          //       Icon(Icons.refresh),
          //     ],
          //   ),
          // ),
          Column(
            children: [
              Text("Saturday 19 MARCH 2016".toUpperCase()),
              // CachedNetworkImage(
              //   height: 200,
              //   width: 200,
              //   imageUrl: "https://openweathermap.org/img/wn/02n@2x.png",
              //   placeholder: (context, url) => CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),

              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/icon_weather/01d.png",
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          "20 oC",
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Partly Cloudy",
                          ),
                          Text(""),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                thickness: 5,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                height: size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(
                      0xFFE5E5E5,
                    ),
                  ),
                ),
                // child: ,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
