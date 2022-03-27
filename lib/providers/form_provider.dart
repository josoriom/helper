import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  int _id = 0;
  String _currentLabel = '';
  int _status = 0;
  String _currentDate = DateTime.now().toString().split(' ')[0];
  double _currentPriority = 1.0;
  bool _currentNotification = false;
  String _currentObservation = '';

  int get getId {
    return _id;
  }

  set setId(int id) {
    _id = id;
    notifyListeners();
  }

  String get getLabel {
    return _currentLabel;
  }

  set setLabel(String label) {
    _currentLabel = label;
    notifyListeners();
  }

  int get getStatus {
    return _status;
  }

  set setStatus(int status) {
    _status = status;
    notifyListeners();
  }

  String get getDate {
    return _currentDate;
  }

  set setDate(String date) {
    _currentDate = date;
    notifyListeners();
  }

  double get getPriority {
    return _currentPriority;
  }

  set setPriority(double priority) {
    _currentPriority = priority;
    notifyListeners();
  }

  bool get getNotification {
    return _currentNotification;
  }

  set setNotification(bool notification) {
    _currentNotification = notification;
    notifyListeners();
  }

  String get getObservation {
    return _currentObservation;
  }

  set setObservation(String observation) {
    _currentObservation = observation;
    notifyListeners();
  }
}
