class LeaderBoard {
  late int rank;
  late String name;
  late String photoUrl;
  late int score;

  LeaderBoard(this.score, this.photoUrl, this.name, {this.rank = 0});
}
