import 'package:flutter/material.dart';

import 'HomeWidget.dart';

class HelloWorldWidget extends StatelessWidget {
  const HelloWorldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => HomeWidget())));
          },
          child: const Text('Hello World'),
        ),
      ),
    );
  }
}
