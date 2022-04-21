import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roll_a_dice/resources/FadePageRoute.dart';
import 'package:roll_a_dice/ui/screens/game_screen.dart';
import 'package:roll_a_dice/ui/screens/leaderboard_screen.dart';
import 'package:roll_a_dice/ui/widgets/profile_widget.dart';
import 'package:roll_a_dice/ui/widgets/score_widget.dart';

import '../../services/authentication/google_authentication.dart';
import '../../services/authentication/user_profile.dart';
import '../../services/score/attempt_stream.dart';
import '../../services/score/score_stream.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _playButtons() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, FadePageRoute(GameScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(6)),
            gradient:
                LinearGradient(colors: [Colors.brown, Colors.brown.shade400])),
        child: const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            'PLAY GAME',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _leaderBoardButtons() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, FadePageRoute(const LeaderBoardScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                topLeft: Radius.circular(4),
                bottomRight: Radius.circular(6)),
            gradient:
                LinearGradient(colors: [Colors.brown, Colors.brown.shade400])),
        child: const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            'LEADERBOARD',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
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
            children: [
              const ProfileWidget(),
              const SizedBox(
                height: 5,
              ),
              ScoreWidget(),
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _playButtons(),
                    const SizedBox(
                      height: 20,
                    ),
                    _leaderBoardButtons()
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
