import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayers/audioplayers.dart';

Future<Map<String, List<String>>> loadJsonData(int chapter) async {
  String jsonString = await rootBundle.loadString('assets/Mathmingle/matchGame/chapter$chapter.json');
  Map<String, dynamic> jsonMap = json.decode(jsonString);
  List<String> spanish = List<String>.from(jsonMap['spanish']);
  List<String> english = List<String>.from(jsonMap['english']);
  return {'spanish': english, 'english': spanish};
}

class AudioHelper {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String word) async {
    String audioFile = 'assets/Mathmingle/audio/${word.toLowerCase()}.mp3';
    await _audioPlayer.play(AssetSource(audioFile));
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
