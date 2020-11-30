import 'dart:math' show Random;

import 'package:flutter/material.dart';

Random random = new Random();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int number = 0;
  String popUpMessage = '';

  bool isCube(int n) {
    if (n == 0) return true;
    if (n == 1) return true;

    for (int i = 2; i <= n; i++) {
      if (n == i * i * i) return true;
      if (n < i * i * i) return false;
    }

    return false;
  }

  bool isSquare(int n) {
    if (n == 0) return true;
    if (n == 1) return true;
    for (int i = 2; i <= n; i++) {
      if (n == i * i) return true;
      if (n < i * i) return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController Tcontroller = new TextEditingController();
    return Form(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Number Shapes',
            //  style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please input a number to see if it is a square or a cube.',
                style: TextStyle(height: 1, fontSize: 23.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: Tcontroller,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  number = int.parse(value);

                  if (isCube(number) == true)
                    popUpMessage = 'Number ${number} is CUBE.';
                  if (isSquare(number) == true)
                    popUpMessage = 'Number ${number} is SQUARE.';
                  if (isSquare(number) == true && isCube(number) == true)
                    popUpMessage = 'Number ${number} is both SQUARE and CUBE.';
                  if (isSquare(number) == false && isCube(number) == false)
                    popUpMessage =
                        'Number ${number} is neither SQUARE nor CUBE.';

                  print(number);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Tcontroller.clear();

            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(number.toString()),
                content: Text(popUpMessage),
              ),
            );
          },
          child: Icon(Icons.check),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
