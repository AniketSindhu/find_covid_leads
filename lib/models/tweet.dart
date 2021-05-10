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
        id: json['_id'],
        url: json['tweet_object']['tweet_url'].toString(),
        text: json['tweet_object']['text'].toString(),
        likes: json['tweet_object']['likes'],
        username: json['create_by'],
        userId: json['tweet_object']['author_id'],
        retweets: json['tweet_object']['retweets']);
  }
}
