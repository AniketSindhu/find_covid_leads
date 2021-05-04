class Tweet {
  String text;
  String url;
  DateTime createdAt;
  Tweet({this.createdAt, this.url, this.text});

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet(
        createdAt: DateTime.parse(json['postedAt']),
        url: json['url'].toString(),
        text: json['text'].toString());
  }
}
