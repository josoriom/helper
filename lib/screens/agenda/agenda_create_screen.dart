import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helper/providers/agenda_list_provider.dart';
import 'package:helper/providers/form_provider.dart';
import 'package:provider/provider.dart';

class AgendaCreateScreen extends StatelessWidget {
  AgendaCreateScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('Nuevo recordatorio',
                style: TextStyle(fontSize: 50, fontFamily: 'RyujinAttack')),
            const SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const SizedBox(width: 100),
                Switch(
                    value: formProvider.getStatus == 0 ? false : true,
                    onChanged: (value) {
                      formProvider.setStatus = value == false ? 0 : 1;
                    })
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: const Text('Etiqueta', style: TextStyle(fontSize: 20))),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: formProvider.getLabel,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      formProvider.setLabel = value;
                    },
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text('Fecha:', style: TextStyle(fontSize: 20)),
              Text(formProvider.getDate,
                  style: TextStyle(fontSize: 30, fontFamily: 'Serif')),
              SizedBox(width: 120),
              FloatingActionButton(
                child: const Icon(
                  Icons.date_range_outlined,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100))
                      .then((date) {
                    print(date);
                    formProvider.setDate = date == null
                        ? DateTime.now().toString().split(' ')[0]
                        : date.toString().split(' ')[0];
                  });
                },
              )
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text('Prioridad', style: TextStyle(fontSize: 20)),
                RatingBar.builder(
                  initialRating: formProvider.getPriority,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  onRatingUpdate: (value) {
                    formProvider.setPriority = value;
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              child: Row(
                children: [
                  const Text('Notificaciones', style: TextStyle(fontSize: 20)),
                  Switch(
                      value: formProvider.getNotification,
                      onChanged: (value) {
                        formProvider.setNotification = value;
                      })
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Observaciones', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: formProvider.getObservation,
                    maxLines: 4,
                    textAlign: TextAlign.justify,
                    onChanged: (value) {
                      formProvider.setObservation = value;
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
          final agendaListProvider =
              Provider.of<AgendaListProvider>(context, listen: false);
          agendaListProvider.newErrand(
            formProvider.getLabel,
            formProvider.getStatus,
            formProvider.getDate,
            formProvider.getPriority.toString(),
            formProvider.getNotification.toString(),
            formProvider.getObservation,
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}
