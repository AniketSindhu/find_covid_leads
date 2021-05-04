import 'package:find_covid_leads/models/tweet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetUI extends StatelessWidget {
  final Tweet tweet;
  TweetUI(this.tweet);
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      VStack(
        [
          HStack(
            [
              FaIcon(
                FontAwesomeIcons.twitter,
                color: Color(0xff0172c0),
              ),
              timeago.format(tweet.createdAt).text.make()
            ],
            alignment: MainAxisAlignment.spaceBetween,
            axisSize: MainAxisSize.max,
          ),
          SizedBox(height: 10),
          SelectableLinkify(
            text: tweet.text,
            onOpen: (url) {
              launch(url.url);
            },
            style: TextStyle(fontSize: 14),
            linkStyle: TextStyle(color: Color(0xff0172c0)),
          ).objectCenterLeft()
        ],
        crossAlignment: CrossAxisAlignment.center,
      ).p12(),
    ]);
  }
}
