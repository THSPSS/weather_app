import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
            Container(
              width: double.infinity,
              child: const Card(
                child: Column(
                  children: [
                     Text('300.67°F',
                     style : TextStyle(fontSize: 32 , fontWeight: FontWeight.bold)
                     ),
                ],),
              ),
            ),
            const SizedBox(height: 10.0,),
            //weather forecase section
            const Text('Weather Forecase',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )
            ),
            const SizedBox(height: 10.0,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                Container(width: 100, height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), 
                  color: Colors.white10,
                  )
                ,child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('09:00'),
                    Icon(Icons.cloud),
                    Text('301.09')
                ],),
                ),
                const SizedBox(width: 10.0,),
                Container(width: 100, height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), 
                  color: Colors.white10,
                  )
                ,child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('09:00'),
                    Icon(Icons.cloud),
                    Text('301.09')
                ],),
                ),
                const SizedBox(width: 10.0,),
                Container(width: 100, height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), 
                  color: Colors.white10,
                  )
                ,child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('09:00'),
                    Icon(Icons.cloud),
                    Text('301.09')
                ],),
                ),
                const SizedBox(width: 10.0,),
                Container(width: 100, height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), 
                  color: Colors.white10,
                  )
                ,child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('09:00'),
                    Icon(Icons.cloud),
                    Text('301.09')
                ],),
                ),
                const SizedBox(width: 10.0,),
                      Container(width: 100, height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), 
                  color: Colors.white10,
                  )
                ,child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('09:00'),
                    Icon(Icons.cloud),
                    Text('301.09')
                ],),
                ),
              ],),
            ),
            const SizedBox(height: 10.0,),
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
                SizedBox(
                  width: 100, 
                  height: 100,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.water_drop),
                    Text('Humidity'),
                    Text('94', style: TextStyle(fontWeight: FontWeight.bold))
                ],),
                ),
                SizedBox(
                  width: 100, 
                  height: 100,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wind_power),
                    Text('Wind Speed'),
                    Text('7.67' , style: TextStyle(fontWeight: FontWeight.bold))
                ],),
                ),
                SizedBox(
                  width: 100, 
                  height: 100,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.umbrella),
                    Text('Pressure'),
                    Text('1006' , style: TextStyle(fontWeight: FontWeight.bold))
                ],),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}