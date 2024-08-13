import 'package:flutter/material.dart';
import 'package:media_booster/Model/AudioModel.dart';

class Audioprovider with ChangeNotifier {
  AudioModel audioModel = AudioModel(isPlay: false);

  void AudioPlay() {
    audioModel.isPlay = !audioModel.isPlay;

    notifyListeners();
  }
}
