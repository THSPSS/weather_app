import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecase_itme.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/loading_container.dart';
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {


  Future<Map<String,dynamic>> getCurrentWeather() async {
    try {
      String lat = '35.891621';
      String lon = '128.619415';
      final result = await http.get(
      Uri.parse('https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$openWeatherAPIKey')    
      );
      final data = jsonDecode(result.body);
      if(data['cod'].toString() != 'null') {
        throw 'An unexpected error occured';
      }
      print('main weather ${data['current']['weather'][0]['main']}');
      print('main weather description ${data['current']['weather'][0]['description']}');

      return data;
     } catch(e) {
      throw e.toString();
     }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App' , style : TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          //InkWell : splash effect (but on dark mode it does not show)
          //GestureDetector : no splash effect
          //icon button set its own padding and splash effect along with icon shape
          IconButton(
            onPressed: (){
              print('refresh');
            }, 
            icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context , snapshot) {
          print('snapshot $snapshot');
          print(snapshot.runtimeType);
          //snapshot catches the state of future function (in this case get Current Weather)
          if(snapshot.connectionState == ConnectionState.waiting) {
            //instead of showing CircularProgressIndicator
            //showing shimmer loading animation
            //CircularProfressIndicator.adaptive
            return const Column(
              children: [
              LoadingContainer(height: 180),
              SizedBox(height: 20,),
              LoadingContainer(width: 200, height: 20),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    LoadingContainer(width: 100, height: 110),
                    LoadingContainer(width: 100, height: 110),
                    LoadingContainer(width: 100, height: 110),
                    LoadingContainer(width: 100, height: 110),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              LoadingContainer(width: 220, height: 20),
              SizedBox(height: 10,),
              LoadingContainer(height: 150),
              ],
            );
          }

          if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;

          final currentTemp = data['current']['temp'];
          final currentMain = data['current']['weather'][0]['main'];

          return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //set text titles to positioned from start
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //using placeholder , fallbackheight : if widget does not have child than it takes fallbackheight
              // Container(
              //   padding: const EdgeInsetsDirectional.all(20.0),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10.0),
              //     color: Colors.white12,
              //   ),
              //   child: const Column(
              //     children: [
              //       Text('300.67F', 
              //         style : TextStyle(
              //           fontWeight: FontWeight.w600,
              //           fontSize: 35.0
              //       )),
              //       SizedBox(height: 15.0,),
              //       Icon(Icons.cloud , size : 60.0),
              //       SizedBox(height: 15.0,),
              //       Text('Rain' , style: TextStyle(fontSize: 18.0))
              //     ],
              //   ),
              // ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX : 10 , sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                             Text(
                              '$currentTemp K' ,
                              style : const TextStyle(fontSize: 32 , fontWeight: FontWeight.bold)
                             ),
                             const SizedBox(height: 16,),
                             Icon(currentMain == 'cloud' || currentMain == 'Rain' ? Icons.cloud : Icons.sunny, size : 64),
                             const SizedBox(height: 16,),
                             Text(currentMain,
                             style : const TextStyle(fontSize: 20)
                             ),
                        ],),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              //weather forecase section
              const Text(
                'Weather Forecase',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
              const SizedBox(height: 10.0,),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                  HourlyForecaseItem(time: '09:00' , icon: Icons.cloud , temperature: '301.22'),
                  HourlyForecaseItem(time: '09:30' , icon: Icons.sunny , temperature: '300.00'),
                  HourlyForecaseItem(time: '10:00' , icon: Icons.sunny , temperature: '302.21'),
                  HourlyForecaseItem(time: '10:30' , icon: Icons.cloud , temperature: '280.43'),
                  HourlyForecaseItem(time: '11:00' , icon: Icons.cloud , temperature: '300.32')
                ],),
              ),
              const SizedBox(height: 20.0,),
              //Additional Information
              const Text('Additional Information',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
              const SizedBox(height: 10.0,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItme(icon: Icons.water_drop, label: 'Humidity' , value: '91'),
                  AdditionalInfoItme(icon: Icons.air, label: 'Wind Speed' , value: '7.5'),
                  AdditionalInfoItme(icon: Icons.beach_access, label: 'Pressure' , value: '1000'),
                ],
              ),
            ],
          ),
        );
        },
      )
    );
  }
}
