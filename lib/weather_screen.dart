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
              setState(() {});
            }, 
            icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context , snapshot) {
          //snapshot catches the state of future function (in this case get Current Weather)
          if(snapshot.connectionState == ConnectionState.waiting) {
            //instead of showing CircularProgressIndicator
            //showing shimmer loading animation
            //CircularProfressIndicator.adaptive
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

          final currentWeather = data['current'];

          final currentTemp = currentWeather['temp'];
          final currentMain = currentWeather['weather'][0]['main'];
          final currentHumidity = currentWeather['humidity'];
          final currentWindSpeed = currentWeather['wind_speed'];
          final currentPressure = currentWeather['pressure'];

          final hourlyWeatherItem = data['hourly'];
          final List<String> hourlydateTime = [];
          final List<String> hourlyMain = [];
          final List<String> hourlyTemp = [];

          //get hourly data and check current time and hourly dt. and houry dt is bigger than current time,
          for(var i = 0 ; i < 5 ; i++) {
            DateTime seoulTime = DateTime.fromMillisecondsSinceEpoch(hourlyWeatherItem[i]['dt'] * 1000, isUtc: true).add(const Duration(hours: 9));

            // Format as hh:mm
            String formattedTime = "${seoulTime.hour.toString().padLeft(2, '0')}:${seoulTime.minute.toString().padLeft(2, '0')}";

            hourlydateTime.add(formattedTime);
            hourlyTemp.add(hourlyWeatherItem[i]['temp'].toString());
            hourlyMain.add(hourlyWeatherItem[i]['weather'][0]['main']);
            //hourlyForecastList.add(HourlyForecaseItem(time: formattedTime , icon: Icons.sunny , temperature: hourlyWeatherItem[i]['temp'].toString()));
          }

          //store each data on list 
          //convert dt to hh:mm format
          //show it on UI 
          return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //set text titles to positioned from start
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //using placeholder , fallbackheight : if widget does not have child than it takes fallbackheight
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
                             Icon(currentMain == 'Clouds' || currentMain == 'Rain' ? Icons.cloud : Icons.sunny, size : 64),
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
                'Hourly Forecase',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
              const SizedBox(height: 10.0,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hourlydateTime.length,
                  itemBuilder: (BuildContext context , int index) {
                    return HourlyForecaseItem(time: hourlydateTime[index] , icon: hourlyMain[index] == 'Clouds' || hourlyMain[index] == 'Rain' ? Icons.cloud : Icons.sunny , temperature: hourlyTemp[index].toString());
                  }
                  ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItme(icon: Icons.water_drop, label: 'Humidity' , value: currentHumidity.toString() ),
                  AdditionalInfoItme(icon: Icons.air, label: 'Wind Speed' , value: currentWindSpeed.toString()),
                  AdditionalInfoItme(icon: Icons.beach_access, label: 'Pressure' , value: currentPressure.toString()),
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
