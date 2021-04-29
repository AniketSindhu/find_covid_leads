import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_covid_leads/methods/getLocations.dart';
import 'package:find_covid_leads/models/post.dart';
import 'package:find_covid_leads/widgets/postWidget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int location = 0;
  int resouce = 0;

  List<String> availableResources = [
    'All',
    'Remdesivir',
    'Favipiravir',
    'Oxygen',
    'Ventilator',
    'Plasma',
    'Tocilizumab',
    'ICU',
    'Beds',
    'Food',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: "Find Covid Leads".text.make(),
          centerTitle: true,
        ),
        backgroundColor: Color(0xffDAE0E6),
        body: Column(
          children: [
            20.heightBox,
            VxDevice(
              mobile: VStack(
                [
                  VxBox(
                          child: VStack([
                    HStack([
                      Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                      ),
                      5.widthBox,
                      "Filter Location".text.bold.size(15).make()
                    ]),
                    10.heightBox,
                    FutureBuilder(
                        future: getLocations(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Container();
                          }
                          return ChipsChoice<int>.single(
                            wrapped: true,
                            value: location,
                            runSpacing: 10,
                            choiceActiveStyle:
                                C2ChoiceStyle(color: Colors.redAccent),
                            onChanged: (val) => setState(() => location = val),
                            choiceItems: C2Choice.listFrom<int, dynamic>(
                              source: snap.data,
                              value: (i, v) => i,
                              label: (i, v) => v,
                            ),
                          );
                        })
                  ]).p12())
                      .width(context.screenWidth * 0.9)
                      .shadowSm
                      .white
                      .roundedSM
                      .make()
                      .py8(),
                  VxBox(
                          child: VStack([
                    HStack([
                      Icon(
                        Icons.local_hospital_rounded,
                        color: Colors.redAccent,
                      ),
                      5.widthBox,
                      "Filter Resources".text.bold.size(15).make()
                    ]),
                    10.heightBox,
                    ChipsChoice<int>.single(
                      wrapped: true,
                      value: resouce,
                      runSpacing: 10,
                      choiceActiveStyle: C2ChoiceStyle(color: Colors.redAccent),
                      onChanged: (val) => setState(() => resouce = val),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: availableResources,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                    )
                  ]).p12())
                      .width(context.screenWidth * 0.9)
                      .shadowSm
                      .white
                      .roundedSM
                      .make()
                      .py8(),
                ],
                alignment: MainAxisAlignment.spaceEvenly,
                axisSize: MainAxisSize.max,
              ),
              web: HStack(
                [
                  VxBox(
                          child: VStack([
                    HStack([
                      Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                      ),
                      5.widthBox,
                      "Filter Location".text.bold.size(15).make()
                    ]),
                    10.heightBox,
                    FutureBuilder(
                        future: getLocations(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Container();
                          }
                          return ChipsChoice<int>.single(
                            wrapped: true,
                            value: location,
                            runSpacing: 10,
                            choiceActiveStyle:
                                C2ChoiceStyle(color: Colors.redAccent),
                            onChanged: (val) => setState(() => location = val),
                            choiceItems: C2Choice.listFrom<int, dynamic>(
                              source: snap.data,
                              value: (i, v) => i,
                              label: (i, v) => v,
                            ),
                          );
                        })
                  ]).p12())
                      .width(context.screenWidth * 0.45)
                      .shadowSm
                      .white
                      .roundedSM
                      .make()
                      .px8(),
                  VxBox(
                          child: VStack([
                    HStack([
                      Icon(
                        Icons.local_hospital_rounded,
                        color: Colors.redAccent,
                      ),
                      5.widthBox,
                      "Filter Resources".text.bold.size(15).make()
                    ]),
                    10.heightBox,
                    ChipsChoice<int>.single(
                      wrapped: true,
                      value: resouce,
                      runSpacing: 10,
                      choiceActiveStyle: C2ChoiceStyle(color: Colors.redAccent),
                      onChanged: (val) => setState(() => resouce = val),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: availableResources,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                    )
                  ]).p12())
                      .width(context.screenWidth * 0.45)
                      .shadowSm
                      .white
                      .roundedSM
                      .make()
                      .px8(),
                ],
                alignment: MainAxisAlignment.spaceEvenly,
                axisSize: MainAxisSize.max,
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('time', descending: true)
                  .snapshots(),
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
                      "Something Went wrong"
                          .text
                          .red500
                          .size(20)
                          .makeCentered(),
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
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          Post post = Post.fromDocument(
                              snapshot.data.docs[index].data());
                          return VxResponsive(
                            xlarge: postWidget(post, context)
                                .width(context.screenWidth * 0.55)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            large: postWidget(post, context)
                                .width(context.screenWidth * 0.55)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            medium: postWidget(post, context)
                                .width(context.screenWidth * 0.75)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            small: postWidget(post, context)
                                .width(context.screenWidth * 0.9)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            xsmall: postWidget(post, context)
                                .width(context.screenWidth * 0.9)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            fallback: postWidget(post, context)
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
              },
            ),
          ],
        ).scrollVertical());
  }
}
