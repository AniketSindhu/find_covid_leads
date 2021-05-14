import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_covid_leads/methods/queryPost.dart';
import 'package:find_covid_leads/models/post.dart';
import 'package:find_covid_leads/widgets/postWidget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VolunteerPost extends StatelessWidget {
  const VolunteerPost({
    Key key,
    @required this.loc,
    @required this.resouce,
    this.controller,
  }) : super(key: key);

  final String loc;
  final List<String> resouce;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: queryPost(loc, resouce),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              40.heightBox,
              CircularProgressIndicator().centered(),
            ],
          );
        } else if (snapshot.data == null || snapshot.hasError) {
          //print(snapshot.data.docs[0].data());
          print(snapshot.error);
          return Column(
            children: [
              40.heightBox,
              "Something Went wrong".text.red500.size(20).makeCentered(),
            ],
          );
        } else {
          if (snapshot.data.docs.length == 0) {
            return Column(
              children: [
                40.heightBox,
                "No leads found".text.red500.size(20).makeCentered(),
              ],
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Post post = Post.fromDocument(snapshot.data.docs[index].data());
                return VxResponsive(
                  xlarge: VxBox(child: PostWidget(post: post, context: context))
                      .width(context.screenWidth * 0.55)
                      .withDecoration(BoxDecoration(
                          border: Border.all(width: 0.3),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)))
                      .makeCentered()
                      .py12(),
                  large: VxBox(child: PostWidget(post: post, context: context))
                      .width(context.screenWidth * 0.55)
                      .withDecoration(BoxDecoration(
                          border: Border.all(width: 0.3),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)))
                      .makeCentered()
                      .py12(),
                  medium: VxBox(child: PostWidget(post: post, context: context))
                      .width(context.screenWidth * 0.75)
                      .withDecoration(BoxDecoration(
                          border: Border.all(width: 0.3),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)))
                      .makeCentered()
                      .py12(),
                  small: VxBox(child: PostWidget(post: post, context: context))
                      .shadow
                      .width(context.screenWidth * 0.9)
                      .withDecoration(BoxDecoration(
                          border: Border.all(width: 0.3),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)))
                      .makeCentered()
                      .py12(),
                  xsmall: VxBox(child: PostWidget(post: post, context: context))
                      .width(context.screenWidth * 0.9)
                      .withDecoration(BoxDecoration(
                          border: Border.all(width: 0.3),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)))
                      .makeCentered()
                      .py12(),
                  fallback:
                      VxBox(child: PostWidget(post: post, context: context))
                          .width(context.screenWidth * 0.75)
                          .withDecoration(BoxDecoration(
                              border: Border.all(width: 0.3),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)))
                          .makeCentered()
                          .py12(),
                );
              }).centered();
        }
      },
    );
  }
}
