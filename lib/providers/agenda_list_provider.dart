import 'package:flutter/material.dart';
import 'package:helper/models/errand_model.dart';
import 'package:helper/providers/db_provider.dart';

class AgendaListProvider extends ChangeNotifier {
  List<ErrandModel> errands = [];
  ErrandModel? errand;
  int selectedStatus = 0;

  Future<ErrandModel> newErrand(String label, int status, String date,
      String priority, String notification, String observation) async {
    final newErrand = ErrandModel(
        label: label,
        status: status,
        date: date,
        priority: priority,
        notification: notification,
        observation: observation);
    final id = await DBProvider.db.newErrand(newErrand);
    newErrand.id = id;
    errands.add(newErrand);
    notifyListeners();
    return newErrand;
  }

  updateErrand(int id, String label, int status, String date, String priority,
      String notification, String observation) async {
    final newErrand = ErrandModel(
        id: id,
        label: label,
        status: status,
        date: date,
        priority: priority,
        notification: notification,
        observation: observation);
    await DBProvider.db.updateErrand(newErrand);
    final errands = await DBProvider.db.getAllErrands();
    this.errands = [...errands];
    notifyListeners();
  }

  loadErrands() async {
    final errands = await DBProvider.db.getAllErrands();
    this.errands = [...errands];
    notifyListeners();
  }

  getErrandById(int id) async {
    errand = await DBProvider.db.getErrandById(id);
    notifyListeners();
  }

  loadErrandsByStatus(int status) async {
    final errands = await DBProvider.db.getErrandsByStatus(status);
    this.errands = [...errands];
    selectedStatus = status;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllErrands();
    errands = [];
    notifyListeners();
  }

  deleteErrandById(int id) async {
    await DBProvider.db.deleteErrand(id);
    loadErrands();
  }

  deleteErrandsByStatus(int status) {
    DBProvider.db.deleteErrandsByStatus(status);
    loadErrands();
  }
}
