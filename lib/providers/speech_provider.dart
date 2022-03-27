import 'package:flutter/material.dart';
import 'dart:math';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechProvider extends ChangeNotifier {
  bool _hasSpeech = false;
  bool _logEvents = false;
  double _level = 0.0;
  double _minSoundLevel = 50000;
  double _maxSoundLevel = -50000;
  String _lastWords = '';
  String _lastError = '';
  String _lastStatus = '';
  String _currentLocaleId = 'es_CO';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        // debugLogging: true,
      );

      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        // _currentLocaleId = systemLocale?.localeId ?? '';
      }

      hasSpeech = hasSpeech;
    } catch (e) {
      _lastError = 'Speech recognition failed: ${e.toString()}';
      _hasSpeech = false;
    }
    notifyListeners();
  }

  Future<void> startListening() async {
    String lastWords = '';
    String lastError = '';
    String result = '';
    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    await speech.listen(
        onResult: resultListener,
        // listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 10),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    _level = 0.0;
    notifyListeners();
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    _level = 0.0;
    notifyListeners();
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  resultListener(SpeechRecognitionResult result) async {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    _lastWords = '${result.recognizedWords} - ${result.finalResult}';
    //print({'result listener ---::>>>', _lastWords});
    notifyListeners();
  }

  String getResult() {
    return _lastWords.split('-').elementAt(0).trim();
  }

  void soundLevelListener(double level) {
    _minSoundLevel = min(_minSoundLevel, level);
    _maxSoundLevel = max(_maxSoundLevel, level);
    _level = level;
    notifyListeners();
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
  }

  double getLevel() {
    return _level;
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    _lastError = '${error.errorMsg} - ${error.permanent}';
    notifyListeners();
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    _lastStatus = status;
    notifyListeners();
  }

  void _switchLang(selectedVal) {
    _currentLocaleId = selectedVal;
    notifyListeners();
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool? val) {
    _logEvents = val ?? false;
    notifyListeners();
  }
}
