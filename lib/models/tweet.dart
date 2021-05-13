class Tweet {
  String text;
  String url;
  DateTime createdAt;
  int retweets;
  int likes;
  String id;
  String username;
  String userId;
  Tweet(
      {this.createdAt,
      this.url,
      this.text,
      this.retweets,
      this.likes,
      this.id,
      this.username,
      this.userId});

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet(
        createdAt: DateTime.parse(json['updatedAt']),
        id: json['tweet_id'],
        url: json['tweet_url'].toString(),
        text: json['text'].toString(),
        likes: json['likes'],
        username: json['created_by'],
        retweets: json['retweets']);
  }
}
