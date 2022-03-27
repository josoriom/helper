import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;

  PageTitle({required this.text});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Whatever',
                fontSize: 50),
          ),
          const SizedBox(height: 25)
        ]),
      ),
    );
  }
}
