import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String _assetPath;
  final double _h;
  final double _w;
  const ImageBanner(this._assetPath, this._h, this._w, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: _h, width: _w),
        // decoration: BoxDecoration(color: Colors.transparent),
        child: Image.asset(
          _assetPath,
          fit: BoxFit.cover,
        ));
  }
}
