class Tweet {
  String text;
  String url;
  DateTime createdAt;
  int retweets;
  int likes;

  Tweet({this.createdAt, this.url, this.text, this.retweets, this.likes});

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet(
        createdAt: DateTime.parse(json['updatedAt']),
        url: json['tweet_object']['tweet_url'].toString(),
        text: json['tweet_object']['text'].toString(),
        likes: json['tweet_object']['likes'],
        retweets: json['tweet_object']['retweets']);
  }
}
