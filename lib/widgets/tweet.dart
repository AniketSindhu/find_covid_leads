import 'package:find_covid_leads/models/tweet.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TweetUI extends StatelessWidget {
  Tweet tweet;
  TweetUI(this.tweet);
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      VStack(
        [
          Text(
            tweet.text,
            style: TextStyle(fontSize: 14),
          ).objectCenterLeft()
        ],
        crossAlignment: CrossAxisAlignment.center,
      ).p12(),
    ]);
  }
}
