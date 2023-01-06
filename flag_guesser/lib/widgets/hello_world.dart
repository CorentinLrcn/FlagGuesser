import 'package:flutter/material.dart';

class HelloWorldWidget extends StatelessWidget {
  const HelloWorldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
