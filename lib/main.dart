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
  bool tryLower = false;
  bool tryHigher = false;
  bool correct = false;
  int currentNumber = 0;
  int correctNumber = random.nextInt(100) + 1;
  bool showGuessButton = true;
  bool showResetButton = false;
  bool enableTextField = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController Tcontroller = new TextEditingController();
    return Form(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Guess my number',
            //  style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: <Widget>[
            Text(
              'I\'m thinking of a number between 1 and 100.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1, fontSize: 26),
            ),
            Text(
              'It\'s your turn to guess my number!\n',
              textAlign: TextAlign.center,
              style: TextStyle(height: 2, fontSize: 20),
            ),
            if (correct == true)
              Text('You guessed ${currentNumber}\nYou guessed right!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1, fontSize: 29, color: Colors.black45)),
            if (tryLower == true)
              Text('You guessed ${currentNumber}\nTry lower!\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1, fontSize: 29, color: Colors.black45)),
            if (tryHigher == true)
              Text('You guessed ${currentNumber}\nTry higher!\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1, fontSize: 29, color: Colors.black45)),
            Text(
              'Try a number!',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1, fontSize: 26, color: Colors.black45),
            ),
            if (enableTextField == true) // cum facem sa nu mai putem scrie in textfield DAR sa ramana pe ecran?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: Tcontroller,
                  onChanged: (value) {
                    correct = false;
                    tryHigher = false;
                    tryLower = false;
                    currentNumber = int.parse(value);
                    print(currentNumber);
                    print('Correct= ${correctNumber}');
                  },
                ),
              ),
            if (showGuessButton == true)
              Container(
                margin:
                    EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      child: Text('Guess!'), // nu am stiut sa pun Try a number,textfieldul si butonul de Guess intr-un singur chenar
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed: () {
                        Tcontroller.clear();
                        setState(() {
                          if (currentNumber == correctNumber)
                            correct = true;
                          else
                            correct = false;
                          if (currentNumber < correctNumber)
                            tryHigher = true;
                          else
                            tryHigher = false;
                          if (currentNumber > correctNumber)
                            tryLower = true;
                          else
                            tryLower = false;
                        });
                        if (correct == true)
                          return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("You guessed right!"),
                              content: Text("It was ${currentNumber}"),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    correctNumber = random.nextInt(100) + 1;
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text("Try again!"),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    showResetButton = true;
                                    showGuessButton = false;
                                    enableTextField = false;
                                    correct = false;
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                      }),
                ),
              ),
            if (showResetButton == true)
              FlatButton(
                  child: Text('Reset'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      showGuessButton = true;
                      showResetButton = false;
                      enableTextField = true;
                      correctNumber = random.nextInt(100) + 1;
                    });
                  }),
          ],
        ),
      ),
    );
  }
}
