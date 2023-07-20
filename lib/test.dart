import 'package:flutter/material.dart';

String left(String input, int length) {
  return input.substring(0, length);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = "Hello, World!";
    String result = left(text, 5);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('LEFT Function Example'),
        ),
        body: Center(
          child: Text(result),
        ),
      ),
    );
  }
}
