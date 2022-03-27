import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedStatus = 0;
  Offset _position = Offset(320.0, 60.0);
  String _message = '';
  String _contact = '';
  bool _showNotification = false;

  Offset get getPosition {
    return _position;
  }

  set setPosition(Offset i) {
    _position = i;
    notifyListeners();
  }

  int get selectedMenuOpt {
    return _selectedStatus;
  }

  set selectedMenuOpt(int i) {
    _selectedStatus = i;
    notifyListeners();
  }

  String get getContact {
    return _contact;
  }

  set setContact(String contact) {
    _contact = contact;
    notifyListeners();
  }

  String get getMessage {
    return _message;
  }

  set setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  bool get getNotification {
    return _showNotification;
  }

  set setNotification(bool notification) {
    _showNotification = notification;
    notifyListeners();
  }
}
