import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  int _id = 0;
  String _contact = '';
  dynamic _phone = 0;
  dynamic _mobil = 0;
  String _addres = '';
  String _nicks = '';

  int get getId {
    return _id;
  }

  set setId(int id) {
    _id = id;
    notifyListeners();
  }

  String get getContact {
    return _contact;
  }

  set setContact(String contact) {
    _contact = contact;
    notifyListeners();
  }

  dynamic get getPhone {
    return _phone;
  }

  set setPhone(dynamic phone) {
    _phone = phone;
    notifyListeners();
  }

  dynamic get getMobil {
    return _mobil;
  }

  set setMobil(dynamic mobil) {
    _mobil = mobil;
    notifyListeners();
  }

  String get getAddres {
    return _addres;
  }

  set setAddres(String addres) {
    _addres = addres;
    notifyListeners();
  }

  String get getNicks {
    return _nicks;
  }

  set setNicks(String nicks) {
    _nicks = nicks;
    notifyListeners();
  }
}
