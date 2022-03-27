import 'package:flutter/material.dart';
import 'package:helper/providers/contact_provider.dart';
import 'package:helper/providers/contacts_list_provider.dart';
import 'package:helper/screens/contacts/contacts_create_screen.dart';
import 'package:provider/provider.dart';

class ContactsEditScreen extends StatelessWidget {
  ContactsEditScreen({Key? key}) : super(key: key);
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
                SizedBox(width: 10),
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
                SizedBox(width: 10),
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
                SizedBox(width: 10),
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
                SizedBox(width: 10),
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
          contactsListProvider.updateContact(
            contactProvider.getId,
            contactProvider.getContact,
            contactProvider.getPhone,
            contactProvider.getMobil,
            contactProvider.getAddres,
            contactProvider.getNicks,
          );
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }
}
