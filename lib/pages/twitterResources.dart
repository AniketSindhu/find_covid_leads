import 'package:find_covid_leads/methods/getTweets.dart';
import 'package:find_covid_leads/widgets/tweet.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TwitterResources extends StatefulWidget {
  final String location;
  final String resource;
  TwitterResources({this.location, this.resource});
  @override
  _TwitterResourcesState createState() => _TwitterResourcesState();
}

class _TwitterResourcesState extends State<TwitterResources> {
  @override
  Widget build(BuildContext context) {
    if (widget.location == null || widget.resource == null) {
      return Column(
        children: [
          40.heightBox,
          "Select a specific location and one resource to get tweets"
              .text
              .center
              .red500
              .size(20)
              .makeCentered()
              .px12(),
        ],
      );
    }
    return FutureBuilder(
        future: getTweets(widget.location, widget.resource),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                40.heightBox,
                CircularProgressIndicator().centered(),
              ],
            );
          } else if (snapshot.data == null || snapshot.hasError) {
            print(snapshot.error);
            return Column(
              children: [
                40.heightBox,
                "Something Went wrong"
                    .text
                    .red500
                    .size(20)
                    .makeCentered()
                    .px12(),
              ],
            );
          } else {
            if (snapshot.data.isEmpty) {
              return Column(
                children: [
                  40.heightBox,
                  "No tweets found for location ${widget.location} & resource ${widget.resource}"
                      .text
                      .center
                      .red500
                      .size(20)
                      .makeCentered()
                      .px12(),
                ],
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return VxResponsive(
                      xlarge: VxBox(child: TweetUI(snapshot.data[index]))
                          .width(context.screenWidth * 0.55)
                          .withDecoration(BoxDecoration(
                              border: Border.all(width: 0.3),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)))
                          .makeCentered()
                          .py12(),
                      large: VxBox(child: TweetUI(snapshot.data[index]))
                          .width(context.screenWidth * 0.55)
                          .withDecoration(BoxDecoration(
                              border: Border.all(width: 0.3),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)))
                          .makeCentered()
                          .py12(),
                      medium: VxBox(child: TweetUI(snapshot.data[index]))
                          .width(context.screenWidth * 0.75)
                          .withDecoration(BoxDecoration(
                              border: Border.all(width: 0.3),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)))
                          .makeCentered()
                          .py12(),
                      small: VxBox(child: TweetUI(snapshot.data[index]))
                          .shadow
                          .width(context.screenWidth * 0.9)
                          .withDecoration(BoxDecoration(
                              border: Border.all(width: 0.3),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)))
                          .makeCentered()
                          .py12(),
                      xsmall: VxBox(child: TweetUI(snapshot.data[index]))
                          .width(context.screenWidth * 0.9)
                          .withDecoration(BoxDecoration(
                              border: Border.all(width: 0.3),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)))
                          .makeCentered()
                          .py12(),
                      fallback: VxBox(child: TweetUI(snapshot.data[index]))
                          .width(context.screenWidth * 0.75)
                          .withDecoration(BoxDecoration(
                              border: Border.all(width: 0.3),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)))
                          .makeCentered()
                          .py12(),
                    );
                  }).centered().scrollVertical();
            }
          }
        });
  }
}
