import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
    return Shimmer.fromColors(
      baseColor: Colors.white54,
      highlightColor: Colors.white12,
      child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    width: width ?? double.infinity,
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  )
            ),
    );
  }
}