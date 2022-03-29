import 'package:flutter/material.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'package:chaquopy/chaquopy.dart';

class PythonScreen extends StatefulWidget {
  const PythonScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PythonScreen> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  String _outputOrError = "", _error = "";

  Map<String, dynamic> data = Map();
  bool loadImageVisibility = true;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void addIntendation() {
    TextEditingController _updatedController = TextEditingController();

    int currentPosition = _controller.selection.start;

    String controllerText = _controller.text;
    String text = controllerText.substring(0, currentPosition) +
        "    " +
        controllerText.substring(currentPosition, controllerText.length);

    _updatedController.value = TextEditingValue(
      text: text,
      selection: TextSelection(
        baseOffset: _controller.text.length + 4,
        extentOffset: _controller.text.length + 4,
      ),
    );

    setState(() {
      _controller = _updatedController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      minimum: EdgeInsets.only(top: 4),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  focusNode: _focusNode,
                  controller: _controller,
                  minLines: 10,
                  maxLines: 20,
                  decoration: InputDecoration(fillColor: Colors.amber),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    _outputOrError,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        color: Colors.green,
                        onPressed: () => addIntendation(),
                        child: Icon(
                          Icons.arrow_right_alt,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        height: 50,
                        color: Colors.green,
                        child: Text(
                          'run Code',
                        ),
                        onPressed: () async {
                          // to run PythonCode, just use executeCode function, which will return map with following format
                          // {
                          // "textOutputOrError" : output of the code / error generated while running the code
                          // }
                          final _result =
                              await Chaquopy.executeCode(_controller.text);
                          setState(() {
                            _outputOrError = _result['textOutputOrError'] ?? '';
                          });
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
