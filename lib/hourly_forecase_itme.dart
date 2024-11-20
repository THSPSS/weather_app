
import 'package:flutter/material.dart';

class HourlyForecaseItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const HourlyForecaseItem({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature
    });

  @override
  Widget build(BuildContext context) {
    return Card(
                  elevation: 6,
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(time,
                        style : const TextStyle(fontSize: 16.0 , fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 8,),
                        Icon(icon , size: 32),
                        const SizedBox(height: 8,),
                        Text(temperature,
                        style : const TextStyle(fontSize: 14.0)
                        ),
                    ],),
                  ),
                  );}
}
