class Tweet {
  String text;
  String id;
  DateTime createdAt;
  Tweet({this.createdAt, this.id, this.text});

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet(
        createdAt: DateTime.parse(json['created_at']),
        id: json['id'].toString(),
        text: json['text'].toString());
  }
}
