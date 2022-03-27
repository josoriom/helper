import 'package:flutter/material.dart';
import 'package:helper/providers/contact_provider.dart';
import 'package:helper/providers/contacts_list_provider.dart';
import 'package:provider/provider.dart';

class ContactsDisplayScreen extends StatelessWidget {
  const ContactsDisplayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    final contactsListProvider =
        Provider.of<ContactsListProvider>(context, listen: false);
    final contacts = contactsListProvider.contacts;
    final contact = contacts
        .where((element) => element.id == contactProvider.getId)
        .elementAt(0);

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(contact.contact,
                style:
                    const TextStyle(fontSize: 50, fontFamily: 'RyujinAttack')),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Phone', style: TextStyle(fontSize: 20)),
                Icon(Icons.circle,
                    color: contact.phone == 1 ? Colors.green : Colors.red),
                const SizedBox(width: 10),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: const Text('Movil', style: TextStyle(fontSize: 20))),
              Text(contact.mobil.toString(),
                  style: TextStyle(fontSize: 30, fontFamily: 'Serif')),
              SizedBox(width: 150),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: const Text('Addres', style: TextStyle(fontSize: 20))),
              Text(contact.addres,
                  style: const TextStyle(fontSize: 30, fontFamily: 'Serif')),
              const SizedBox(width: 150),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: const Text('Nicks', style: TextStyle(fontSize: 20))),
              Text(contact.nicks,
                  style: const TextStyle(fontSize: 30, fontFamily: 'Serif')),
              const SizedBox(width: 150),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'edit',
        child: const Icon(Icons.edit_outlined, size: 25),
        onPressed: () {
          contactProvider.setContact = contact.contact;
          contactProvider.setPhone = contact.phone;
          contactProvider.setMobil = contact.mobil;
          contactProvider.setAddres = contact.addres;
          contactProvider.setNicks = contact.nicks;
          Navigator.pushNamed(context, 'contacts_edit_screen');
        },
      ),
    );
  }
}
