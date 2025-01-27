import 'package:flutter/material.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/comm_functions.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/languageconverter.dart';
import 'dart:math' as math;
import 'package:supersetfirebase/gamescreen/mathoperations/common/translate/translate.dart';

class FlashCardInfo extends StatelessWidget {
  final int _f;
  final int _s;
  final String _sign;
  final double _size = 30;
  final double fontSize;
  final int currentLanguage;  
  const FlashCardInfo(this._sign, this._f, this._s, this.currentLanguage, {super.key, required this.fontSize});
  
  double get safeFontSize => math.min(fontSize, 20.0);
  
  @override
  Widget build(BuildContext context) {
    int res = get_op_result(_sign, _f, _s);
    int rem = (_sign == '÷') ? _f % _s : 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$_f  ",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
            ),
            Text(
              "$_sign  ",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
            ),
            Text(
              _s.toString(),
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
            ),
            Text(
              '  =  ',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
            ),
            Text(
              res.toString(),
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
            ),
          ],
        ),
        if (_sign == '÷')
          Text(
            currentLanguage == 0 ? "remainder = $rem" : "resto = $rem",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: safeFontSize,
            ),
          ),
        // Conditional Rendering Based on Language
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentLanguage == 0) ...[  // English
              Text(
                "${NumberToWordsEnglish.convert(_f)}  ",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
              Text(
                "$_sign  ",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
              Text(
                NumberToWordsEnglish.convert(_s),
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
              Text(
                '  =  ',
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
              Text(
                NumberToWordsEnglish.convert(res),
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
            ] else if (currentLanguage == 1) ...[  // Spanish
              Text(
                "${NumberToWordsSpanish.convert(_f)}  ",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
              Text(
                "$_sign  ",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
              Text(
                NumberToWordsSpanish.convert(_s),
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
              Text(
                '  =  ',
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
              Text(
                NumberToWordsSpanish.convert(res),
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: safeFontSize),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
