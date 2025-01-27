import 'package:flutter/material.dart';

class PictureForm extends StatelessWidget {
  final String _assetPath = "assets/Mathoperations/orange.png";
  final int num;
  final double size;
  PictureForm({super.key, this.num = 5, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return Row(
                children: List.generate(
                  num,
                      (index) => Container(
                    // margin: EdgeInsets.all(8.0),
                    child: Image.asset(
                      _assetPath, // Replace with your image asset path
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
            );
  }
}


// ImageBanner("assets/Mathoperations/orange.png", 40, 40),