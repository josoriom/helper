import 'dart:math';

import 'package:flutter/material.dart';
import 'package:helper/providers/providers.dart';
import 'package:provider/provider.dart';

class TaskManager {
  BuildContext context;
  String? instruction = 'none';
  String? order;
  TaskManager({required this.context}) {
    final speechProvider = Provider.of<SpeechProvider>(context, listen: false);
    final order = speechProvider.getResult().toLowerCase();
    this.order = order;
    final instructions = ['llamar', 'domicilio', 'mensaje'];
    instruction = 'No entendí';
    for (final element in instructions) {
      final test = order.contains(element);
      instruction = test ? element : instruction;
      if (test) break;
    }
  }

  sendMessage() {
    final contactsListProvider =
        Provider.of<ContactsListProvider>(context, listen: false);
    if (order == null) {
      return {
        'contact': 'No conozco a ese pirobo',
        'number': '',
        'message': 'No le voy a decir nada',
        'instruction': 'lkjhujhlk'
      };
    }
    contactsListProvider.loadContacts();
    final contacts = contactsListProvider.contacts;
    final names = contacts.map((e) => e.contact);
    String contactName = 'unknown';
    for (final name in names) {
      final isIn = order!.contains(name);
      contactName = isIn ? name : contactName;
    }
    dynamic contact =
        contacts.where((element) => element.contact == contactName);
    if (contact.isEmpty) {
      return {
        'contact': 'No conozco a ese pirobo',
        'number': '',
        'message': 'No le voy a decir nada',
        'instruction': 'lkjhujhlk'
      };
    }

    contact = contact.elementAt(0);
    final message = order!.split(contactName);
    return {
      'contact': contactName,
      'number': contact.mobil,
      'message': message.elementAt(1),
      'instruction': instruction
    };
  }
}
