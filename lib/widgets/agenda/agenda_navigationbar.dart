import 'package:flutter/material.dart';
import 'package:helper/providers/agenda_list_provider.dart';
import 'package:helper/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class AgendaNavigationBar extends StatelessWidget {
  const AgendaNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UiProvider>(context);
    final currentStatus = provider.selectedMenuOpt;

    return BottomNavigationBar(
        onTap: ((value) {
          provider.selectedMenuOpt = value;
        }),
        currentIndex: currentStatus,
        showUnselectedLabels: false,
        selectedItemColor: const Color.fromRGBO(31, 111, 140, 1),
        unselectedItemColor: const Color.fromRGBO(116, 117, 152, 1),
        backgroundColor: const Color(0xff202333),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.circle_outlined,
              ),
              label: 'Pendientes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: 'Terminados'),
        ]);
  }
}
