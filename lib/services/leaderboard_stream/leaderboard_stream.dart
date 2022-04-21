import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:roll_a_dice/models/leaderboard.dart';
import 'package:roll_a_dice/storage/firebase_storage.dart';

class LeaderBoardProvider with ChangeNotifier {
  List<LeaderBoard> _leaderBoard = [];

  void fetchLeaderBoard() async {
    _leaderBoard = await FirebaseRealtimeStorage().getLeaderBoard();
    notifyListeners();
  }

  get leaderBoardList => _leaderBoard;
}
