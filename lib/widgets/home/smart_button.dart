import 'package:flutter/material.dart';
import 'package:helper/tools/task_manager/task_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/providers.dart';

class SmartButton extends StatelessWidget {
  const SmartButton({
    Key? key,
    required this.position,
    required this.contactsListProvider,
    required this.speechProvider,
    required this.uiProvider,
  }) : super(key: key);

  final Offset position;
  final ContactsListProvider contactsListProvider;
  final UiProvider uiProvider;
  final SpeechProvider speechProvider;

  @override
  Widget build(BuildContext context) {
    final speechProvider = Provider.of<SpeechProvider>(context);

    final taskManager = TaskManager(context: context);
    dynamic message = {
      'contact': 'No conozco a ese pirobo',
      'number': '',
      'message': 'No le voy a decir nada',
      'instruction': 'lkjhujhlk'
    };
    if (taskManager.instruction == 'mensaje') {
      message = taskManager.sendMessage();
    }
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: speechProvider.getLevel() * 5,
                          color: Colors.black.withOpacity(0.3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
            Draggable(
                feedback: FloatingActionButton(
                    child: const Icon(Icons.smart_toy_outlined),
                    onPressed: () {}),
                child: GestureDetector(
                  // onLongPress: () => Navigator.pushNamed(context, 'speech_screen'),
                  onLongPressStart: (LongPressStartDetails details) {
                    speechProvider.startListening();
                  },
                  onLongPressEnd: (details) {
                    speechProvider.stopListening();
                    if (taskManager.instruction == 'mensaje') {
                      message = taskManager.sendMessage();
                      const Duration(seconds: 1);
                      displayDialog(context, message);
                    }
                  },
                  child: FloatingActionButton(
                    child: const Icon(Icons.smart_toy_outlined),
                    onPressed: () async {},
                  ),
                ),
                childWhenDragging: Container(),
                onDragEnd: (details) {
                  uiProvider.setPosition = details.offset;
                })
          ],
        ));
  }
}

void displayDialog(BuildContext context, message) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(message['contact'])),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                message['message'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                        child: const Text('Yes'),
                        onPressed: () async {
                          await launch(
                              "https://wa.me/${message['number']}?text=${message['message']}");
                          Navigator.pop(context);
                        }),
                    TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                          secondDialog(context);
                        })
                  ])
            ],
          ),
        );
      });
}

void secondDialog(BuildContext context) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('Algo nuevo')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Algo nuevo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                        child: const Text('Yes'),
                        onPressed: () async {
                          Navigator.pop(context);
                        }),
                    TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ])
            ],
          ),
        );
      });
}
