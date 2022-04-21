import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roll_a_dice/services/score/attempt_stream.dart';
import 'package:roll_a_dice/services/score/score_stream.dart';
import 'package:roll_a_dice/ui/screens/leaderboard_screen.dart';
import 'package:roll_a_dice/ui/widgets/dialogs.dart';
import 'package:roll_a_dice/ui/widgets/profile_widget.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ScoreStream _scoreStream = ScoreStream();
  final AttemptStream _attemptStream = AttemptStream();

  Widget _scoreWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          boxShadow: const [
            BoxShadow(
              color: Colors.blue,
              offset: Offset(0, 9),
            ),
          ],
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder<int>(
                stream: _scoreStream.score,
                builder: (context, snapshot) {
                  int currentScore = 0;
                  if (snapshot.hasData && snapshot.data != null) {
                    currentScore = snapshot.data!;
                  }
                  return Text(
                    'Your Score: $currentScore',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  );
                }),
            StreamBuilder<int>(
                stream: _attemptStream.attempts,
                builder: (context, snapshot) {
                  int currentAttempt = 0;
                  if (snapshot.hasData && snapshot.data != null) {
                    currentAttempt = snapshot.data!;
                  }
                  return Text('Attempts: $currentAttempt/10');
                }),
          ],
        ),
      ),
    );
  }

  Widget _rollADiceButton() {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(12),
            backgroundColor: MaterialStateProperty.all(Colors.brown)),
        onPressed: () {
          if (_attemptStream.currentAttempts != 10) {
            int randomDiceValue = 1 + Random().nextInt(7 - 1);
            _scoreStream.scoreEvent.add(randomDiceValue);
            _attemptStream.increment();
          } else {
            AttemptsCompletedDialog(context);
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Roll the dice'),
        ));
  }

  Widget _dice() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Your Got',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<int>(
              stream: _scoreStream.currentValue,
              builder: (context, snapshot) {
                int currentValue = 0;
                if (snapshot.hasData && snapshot.data != null) {
                  currentValue = snapshot.data!;
                }
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/dice.png',
                    ),
                    Text(
                      currentValue.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.lightBlueAccent, Colors.blue], radius: 0.8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileWidget(),
              const SizedBox(
                height: 5,
              ),
              _scoreWidget(),
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_dice(), _rollADiceButton()],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
