import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roll_a_dice/services/score/attempt_stream.dart';
import 'package:roll_a_dice/services/score/score_stream.dart';
import 'package:roll_a_dice/ui/screens/leaderboard_screen.dart';
import 'package:roll_a_dice/ui/widgets/profile_widget.dart';
import 'package:roll_a_dice/ui/widgets/score_widget.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ScoreStream _scoreStream = ScoreStream();
  final AttemptStream _attemptStream = AttemptStream();

  Widget _rollADiceButton() {
    return ElevatedButton(
        onPressed: () {
          if (_attemptStream.currentAttempts != 10) {
            int randomDiceValue = 1 + Random().nextInt(7 - 1);
            _scoreStream.scoreEvent.add(randomDiceValue);
            _attemptStream.increment();
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('You are done')));
          }
        },
        child: Text('Roll the dice'));
  }

  Widget _leaderBoardbutton() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LeaderBoardScreen()));
        },
        child: const Text('LeaderBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileWidget(),
                ScoreWidget(),
                _rollADiceButton(),
                _leaderBoardbutton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
