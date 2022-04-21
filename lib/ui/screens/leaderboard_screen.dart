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
        return leaderBoardList.isEmpty
            ? const Expanded(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Text(
                  "Fetching leaderboard...",
                  style: TextStyle(fontSize: 16),
                )),
              )
            : ListView.builder(
                itemCount: leaderBoardList.length - 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: leaderBoardList[index].photoUrl == 'photo'
                              ? const CircleAvatar(
                                  child: Icon(Icons.person),
                                )
                              : CircleAvatar(
                                  foregroundImage: Image.network(
                                          leaderBoardList[index].photoUrl)
                                      .image,
                                ),
                          title: Text(
                            leaderBoardList[index].name.toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                          trailing: Text(
                            'Score: ${leaderBoardList[index].score}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
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
      appBar: AppBar(
        title: const Text('LeaderBoard'),
      ),
      body: SafeArea(
        child: Column(
          children: [_leaderBoardList()],
        ),
      ),
    );
  }
}
