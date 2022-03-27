import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:helper/screens/screens.dart';
import 'package:helper/widgets/widgets.dart';
import 'package:helper/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final speechProvider = Provider.of<SpeechProvider>(context, listen: false);
    speechProvider.initSpeechState();
    final uiProvider = Provider.of<UiProvider>(context);
    final contactsListProvider =
        Provider.of<ContactsListProvider>(context, listen: false);
    contactsListProvider.loadContacts();
    Offset position = uiProvider.getPosition;
    return Scaffold(
      body: Stack(children: [
        // Background
        const Background(),
        _HomeBody(),
        SmartButton(
            position: position,
            contactsListProvider: contactsListProvider,
            speechProvider: speechProvider,
            uiProvider: uiProvider),
      ]),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  _HomeBody({
    Key? key,
  }) : super(key: key);

  final List<Map<String, dynamic>> homeCards = [
    {
      'route': 'home_math_screen',
      'name': 'Matematicás',
      'screen': const MathMenuScreen(),
      'icon': Icons.emoji_symbols_rounded,
      'color': Colors.blue
    },
    {
      'route': 'home_chem_screen',
      'name': 'Química',
      'screen': const ChemMenuScreen(),
      'icon': Icons.whatshot_outlined,
      'color': Colors.green
    },
    {
      'route': 'agenda_screen',
      'name': 'Agenda',
      'screen': AgendaScreen(),
      'icon': Icons.book,
      'color': Colors.deepPurpleAccent
    },
    {
      'route': 'contacts_screen',
      'name': 'Contactos',
      'screen': ContactsScreen(),
      'icon': Icons.perm_contact_cal_outlined,
      'color': const Color.fromARGB(255, 153, 38, 72)
    }
  ];

  @override
  Widget build(BuildContext context) {
    final agendaListProvider =
        Provider.of<AgendaListProvider>(context, listen: false);
    agendaListProvider.loadErrands();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PageTitle(text: ''),
            _StatusTrack(),
            // Card table
            CardTable(homeCards: homeCards)
          ],
        ),
      ),
    );
  }
}

class _StatusTrack extends StatelessWidget {
  _StatusTrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final agendaListProvider = Provider.of<AgendaListProvider>(context);
    final list = agendaListProvider.errands;
    return Container(
      margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(5, 76, 102, 1),
                borderRadius: BorderRadius.circular(20)
                // end
                ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(height: 15),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 10),
                        for (int i = 0; i < list.length; i++)
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              _ListItem(
                                  label: list[i].label,
                                  value: list[i].priority),
                            ],
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  String label;
  String value;

  _ListItem({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(Icons.assignment_outlined, color: Colors.white),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const Icon(Icons.star, color: Colors.red)
          ],
        )
      ],
    );
  }
}
