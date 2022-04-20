import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/services/authentication/google_authentication.dart';
import 'package:roll_a_dice/services/authentication/user_profile.dart';
import 'package:roll_a_dice/services/score/attempt_stream.dart';
import 'package:roll_a_dice/services/score/score_stream.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ScoreStream _scoreStream = ScoreStream();
  final AttemptStream _attemptStream = AttemptStream();

  Widget _profileSection() {
    User? user = UserProfileProvider().userProfile;
    if (user == null) {
      LoginWithGoogle().signOut();
    }
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          leading: user!.photoURL == null
              ? const Icon(Icons.person)
              : Image.network(user.photoURL!),
          title: Text(user.displayName!),
        ));
  }

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

  Widget _scoreWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StreamBuilder<int>(
            stream: _scoreStream.score,
            builder: (context, snapshot) {
              int currentScore = 0;
              if (snapshot.hasData && snapshot.data != null) {
                currentScore = snapshot.data!;
              }
              return Text('Your Score: $currentScore');
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
    );
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
              children: [_profileSection(), _scoreWidget(), _rollADiceButton()],
            ),
          ),
        ),
      ),
    );
  }
}
