import 'package:flutter/material.dart';

class AdditionalInfoItme extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfoItme({
    super.key,
    required this.icon,
    required this.label,
    required this.value
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: 100, 
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon , size: 32),
                const SizedBox(height: 8,),
                Text(label),
                const SizedBox(height: 8,),
                Text(value, 
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                  ))
              ],),
            ),
           );
  }
}