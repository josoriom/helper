import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helper/providers/agenda_list_provider.dart';
import 'package:helper/providers/form_provider.dart';
import 'package:provider/provider.dart';

class AgendaDisplayScreen extends StatelessWidget {
  const AgendaDisplayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final agendaListProvider =
        Provider.of<AgendaListProvider>(context, listen: false);
    final errands = agendaListProvider.errands;
    print({
      'id',
      formProvider.getId,
      'label',
      formProvider.getLabel,
      'status',
      formProvider.getStatus
    });

    final errand = errands
        .where((element) => element.id == formProvider.getId)
        .elementAt(0);

    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(errand.label,
                style: TextStyle(fontSize: 50, fontFamily: 'RyujinAttack')),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Status', style: TextStyle(fontSize: 20)),
                Icon(Icons.circle,
                    color: errand.status == 1 ? Colors.green : Colors.red),
                const SizedBox(width: 10),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: const Text('Fecha', style: TextStyle(fontSize: 20))),
              Text(errand.date,
                  style: TextStyle(fontSize: 30, fontFamily: 'Serif')),
              SizedBox(width: 150),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text('Prioridad', style: TextStyle(fontSize: 20)),
                RatingBar.builder(
                  initialRating: double.parse(errand.priority),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  onRatingUpdate: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.circle,
                    color: errand.notification == 'true'
                        ? Colors.green
                        : Colors.red),
                const SizedBox(width: 10),
                const Text('Notificaciones', style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 30),
            Container(
                alignment: Alignment.topLeft,
                child: const Text('Observaciones:',
                    style: TextStyle(fontSize: 20))),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(5, 76, 102, 0.1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 200,
                          child: Text(
                            errand.observation,
                            style: TextStyle(fontSize: 20),
                            maxLines: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'edit',
        child: const Icon(Icons.edit_outlined, size: 25),
        onPressed: () {
          formProvider.setLabel = errand.label;
          formProvider.setDate = errand.date;
          formProvider.setNotification =
              errand.notification == 'true' ? true : false;
          formProvider.setPriority = double.parse(errand.priority);
          formProvider.setObservation = errand.observation;
          formProvider.setStatus = errand.status;
          Navigator.pushNamed(context, 'agenda_edit_screen');
        },
      ),
    );
  }
}
