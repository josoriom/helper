import 'package:flutter/material.dart';
import 'package:helper/models/errand_model.dart';
import 'package:helper/providers/agenda_list_provider.dart';
import 'package:helper/providers/form_provider.dart';
import 'package:helper/providers/ui_provider.dart';
import 'package:helper/themes/themes.dart';
import 'package:helper/widgets/agenda/agenda_navigationbar.dart';
import 'package:provider/provider.dart';

class AgendaScreen extends StatelessWidget {
  // const AgendaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de recordatorios')),
      body: _TaskCard(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final formProvider =
              Provider.of<FormProvider>(context, listen: false);
          formProvider.setLabel = '';
          formProvider.setDate = DateTime.now().toString().split(' ')[0];
          formProvider.setNotification = false;
          formProvider.setPriority = 1;
          formProvider.setObservation = '';
          Navigator.pushNamed(context, 'agenda_create_screen');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AgendaNavigationBar(),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final agendaListProvider = Provider.of<AgendaListProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final status = uiProvider.selectedMenuOpt;
    if (status == 0) {
      agendaListProvider.loadErrandsByStatus(0);
    } else {
      agendaListProvider.loadErrandsByStatus(1);
    }
    final errands = agendaListProvider.errands;
    return ListView.builder(
      itemCount: errands.length,
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
                            Text(errands[i].date,
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(errands[i].priority.toString()),
                              Icon(Icons.star,
                                  color: double.parse(errands[i].priority) < 3
                                      ? Colors.green
                                      : double.parse(errands[i].priority) == 3
                                          ? Colors.yellow
                                          : Colors.red)
                            ]),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    contentPadding: const EdgeInsets.all(10),
                    minVerticalPadding: 5,
                    title: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(Icons.circle,
                              size: 15,
                              color: errands[i].notification == 'true'
                                  ? Colors.green
                                  : Colors.red),
                          const SizedBox(width: 3),
                          Text(errands[i].label),
                        ],
                      ),
                    ),
                    subtitle:
                        Text(splitObservation(errands[i].observation, 30)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Eliminar'),
                          onPressed: () {
                            Provider.of<AgendaListProvider>(context,
                                    listen: false)
                                .deleteErrandById(errands[i].id);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
          onTap: () {
            Navigator.pushNamed(context, 'agenda_display_screen');
            formProvider.setId = errands[i].id;
          },
        );
      },
    );
  }
}

String splitObservation(String observation, int max) {
  final words = observation.split(" ");
  if (words.length < max) {
    return words.join(" ");
  } else {
    return words.sublist(0, max).join(" ");
  }
}
