import 'package:flutter/material.dart';
import 'package:helper/models/models.dart';
import 'package:helper/providers/db_provider.dart';

class ContactsListProvider extends ChangeNotifier {
  List<ContactsModel> contacts = [];
  ContactsModel? contact;
  int selectedStatus = 0;

  Future<ContactsModel> newContact(
      String contact, int phone, int mobil, String addres, String nicks) async {
    final newContact = ContactsModel(
        contact: contact,
        phone: phone,
        mobil: mobil,
        addres: addres,
        nicks: nicks);
    final id = await DBProvider.db.newContact(newContact);
    newContact.id = id;
    contacts.add(newContact);
    notifyListeners();
    return newContact;
  }

  updateContact(int id, String contact, int phone, int mobil, String addres,
      String nicks) async {
    final newContact = ContactsModel(
        id: id,
        contact: contact,
        phone: phone,
        mobil: mobil,
        addres: addres,
        nicks: nicks);
    await DBProvider.db.updateContact(newContact);
    final contacts = await DBProvider.db.getAllContacts();
    this.contacts = [...contacts];
    notifyListeners();
  }

  loadContacts() async {
    final contacts = await DBProvider.db.getAllContacts();
    this.contacts = [...contacts];
    notifyListeners();
  }

  getContactById(int id) async {
    contact = await DBProvider.db.getContactById(id);
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllContacts();
    contacts = [];
    notifyListeners();
  }

  deleteContactById(int id) async {
    await DBProvider.db.deleteContact(id);
    loadContacts();
  }
}
