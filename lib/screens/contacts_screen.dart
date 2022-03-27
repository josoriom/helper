import 'package:flutter/material.dart';
import 'package:helper/providers/contact_provider.dart';
import 'package:helper/themes/themes.dart';
import 'package:helper/widgets/agenda/agenda_navigationbar.dart';
import 'package:provider/provider.dart';

import '../providers/contacts_list_provider.dart';

class ContactsScreen extends StatelessWidget {
  // const AgendaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de contactos')),
      body: _TaskCard(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final contactProvider =
              Provider.of<ContactProvider>(context, listen: false);
          contactProvider.setContact = '';
          contactProvider.setPhone = 3000000000;
          contactProvider.setMobil = 3000000000;
          contactProvider.setAddres = '';
          contactProvider.setNicks = '';
          Navigator.pushNamed(context, 'contacts_create_screen');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: AppTheme.primary,
          notchMargin: 4.0,
          clipBehavior: Clip.antiAlias),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    final contactsListProvider = Provider.of<ContactsListProvider>(context);
    contactsListProvider.loadContacts();
    final contacts = contactsListProvider.contacts;
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (_, i) {
        return GestureDetector(
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 8,
              shadowColor: AppTheme.primary.withOpacity(0.5),
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(contacts[i].contact,
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text(contacts[i].phone.toString())]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Eliminar'),
                          onPressed: () {
                            Provider.of<ContactsListProvider>(context,
                                    listen: false)
                                .deleteContactById(contacts[i].id);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
          onTap: () {
            Navigator.pushNamed(context, 'contacts_display_screen');
            contactProvider.setId = contacts[i].id;
          },
        );
      },
    );
  }
}
