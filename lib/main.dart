import 'dart:math' show Random;

import 'package:flutter/material.dart';

Random random = Random();

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
    final TextEditingController tcontroller = TextEditingController();
    return Form(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Guess my number',
            //  style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: <Widget>[
            const Text(
              'I\'m thinking of a number between 1 and 100.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1, fontSize: 26),
            ),
            const Text(
              'It\'s your turn to guess my number!\n',
              textAlign: TextAlign.center,
              style: TextStyle(height: 2, fontSize: 20),
            ),
            if (correct == true)
              Text('You guessed $currentNumber\nYou guessed right!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      height: 1, fontSize: 29, color: Colors.black45)),
            if (tryLower == true)
              Text('You guessed $currentNumber\nTry lower!\n',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      height: 1, fontSize: 29, color: Colors.black45)),
            if (tryHigher == true)
              Text('You guessed $currentNumber\nTry higher!\n',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      height: 1, fontSize: 29, color: Colors.black45)),
            const Text(
              'Try a number!',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1, fontSize: 26, color: Colors.black45),
            ),
            if (enableTextField ==
                true) // cum facem sa nu mai putem scrie in textfield DAR sa ramana pe ecran?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  controller: tcontroller,
                  onChanged: (String value) {
                    correct = false;
                    tryHigher = false;
                    tryLower = false;
                    currentNumber = int.parse(value);
                    print(currentNumber);
                    print('Correct= $correctNumber');
                  },
                ),
              ),
            if (showGuessButton == true)
              Container(
                margin:
                    const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 50),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      child: const Text('Guess!'),
                      // nu am stiut sa pun Try a number,textfieldul si butonul de Guess intr-un singur chenar
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed: () {
                        tcontroller.clear();
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
                          return showDialog<void>(
                            context: context,
                            builder: (BuildContext ctx) => AlertDialog(
                              title: const Text('You guessed right!'),
                              content: Text('It was $currentNumber'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    correctNumber = random.nextInt(100) + 1;
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('Try again!'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    showResetButton = true;
                                    showGuessButton = false;
                                    enableTextField = false;
                                    correct = false;
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                      }),
                ),
              ),
            if (showResetButton == true)
              FlatButton(
                  child: const Text('Reset'),
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
