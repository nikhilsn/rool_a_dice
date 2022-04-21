import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roll_a_dice/resources/FadePageRoute.dart';
import 'package:roll_a_dice/resources/constants.dart';
import 'package:roll_a_dice/ui/screens/game_screen.dart';
import 'package:roll_a_dice/ui/screens/leaderboard_screen.dart';
import 'package:roll_a_dice/ui/widgets/profile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _playButtons() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, FadePageRoute(GameScreen()));
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
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            Constants.playGame,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _leaderBoardButtons() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, FadePageRoute(const LeaderBoardScreen()));
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
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            Constants.leaderBoard,
            style: const TextStyle(
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
          child: Stack(
            children: [
              Positioned(
                top: 200,
                left: 20,
                child: Image.asset(
                  'assets/dice1.png',
                  scale: 0.9,
                ),
              ),
              Positioned(
                top: 300,
                right: 20,
                child: Image.asset(
                  'assets/dice3.png',
                  scale: 0.9,
                ),
              ),
              Positioned(
                bottom: 200,
                left: 100,
                child: Image.asset(
                  'assets/dice5.png',
                  scale: 0.9,
                ),
              ),
              Positioned(
                bottom: 300,
                right: 20,
                child: Image.asset(
                  'assets/dice6.png',
                  scale: 0.9,
                ),
              ),
              Column(
                children: [
                  const ProfileWidget(),
                  const SizedBox(
                    height: 5,
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
