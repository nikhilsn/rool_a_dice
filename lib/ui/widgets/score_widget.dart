import 'package:flutter/material.dart';

import '../../services/score/attempt_stream.dart';
import '../../services/score/score_stream.dart';

class ScoreWidget extends StatelessWidget {
  ScoreWidget({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return _scoreWidget();
  }
}
