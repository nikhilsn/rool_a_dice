import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/models/leaderboard.dart';
import 'package:roll_a_dice/services/leaderboard_stream/leaderboard_stream.dart';
import 'package:roll_a_dice/storage/firebase_storage.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  Widget _leaderBoardList() {
    return Consumer<LeaderBoardProvider>(
      builder: (context, snapshot, child) {
        List<LeaderBoard> leaderBoardList = snapshot.leaderBoardList;
        return leaderBoardList.length == 0
            ? Container(
                child: const Text("Loading data"),
              )
            : ListView.builder(
                itemCount: leaderBoardList.length - 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 300,
                      color: Colors.black,
                      child: Text(
                        leaderBoardList[index].score.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<LeaderBoardProvider>(context, listen: false).fetchLeaderBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_leaderBoardList()],
        ),
      ),
    );
  }
}
