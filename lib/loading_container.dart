import 'package:flutter/material.dart';
import 'package:weather_app/shimmer_loading.dart';

class LoadingContainer extends StatelessWidget {
  final double? width;
  final double height;
  const LoadingContainer({
    super.key,
    this.width,
    required this.height
    });

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      //for test stage code
      isLoading: true,
      child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    width: width ?? double.infinity,
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  )
            ),
    );
  }
}