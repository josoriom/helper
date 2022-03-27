import 'package:flutter/material.dart';
import 'package:helper/providers/contact_provider.dart';
import 'package:helper/providers/contacts_list_provider.dart';
import 'package:provider/provider.dart';

class ContactsCreateScreen extends StatelessWidget {
  ContactsCreateScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: const Text('Contacto', style: TextStyle(fontSize: 20))),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: contactProvider.getContact,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      contactProvider.setContact = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: const Text('Phone', style: TextStyle(fontSize: 20))),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: contactProvider.getPhone.toString(),
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      contactProvider.setPhone = ensureNumber(value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: const Text('Movil', style: TextStyle(fontSize: 20))),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: contactProvider.getMobil.toString(),
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      contactProvider.setMobil = ensureNumber(value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: const Text('Dirección', style: TextStyle(fontSize: 20))),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: contactProvider.getAddres,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      contactProvider.setAddres = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Nicks', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: contactProvider.getNicks,
                    maxLines: 4,
                    textAlign: TextAlign.justify,
                    onChanged: (value) {
                      contactProvider.setNicks = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'save',
        child: const Icon(Icons.save_outlined, size: 25),
        onPressed: () {
          final contactsListProvider =
              Provider.of<ContactsListProvider>(context, listen: false);
          contactsListProvider.newContact(
            contactProvider.getContact,
            contactProvider.getPhone,
            contactProvider.getMobil,
            contactProvider.getAddres,
            contactProvider.getNicks,
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}

dynamic ensureNumber(String number) {
  number = number.replaceAll(RegExp(r'[^0-9]+'), '');
  final result = number == '' ? number : int.parse(number);
  return result;
}
