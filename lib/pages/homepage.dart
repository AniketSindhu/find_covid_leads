import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_covid_leads/methods/queryPost.dart';
import 'package:find_covid_leads/models/post.dart';
import 'package:find_covid_leads/widgets/mobileFilter.dart';
import 'package:find_covid_leads/widgets/postWidget.dart';
import 'package:find_covid_leads/widgets/webFilter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int location = 0;
  String loc = 'All';
  int resouce = 0;
  bool showMoreLoc = false;
  bool showMoreResources = false;
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
  void updateLoc(val) {
    setState(() {
      loc = val;
    });
  }

  void updateRes(val) {
    setState(() {
      resouce = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: VStack([
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.bug_report,
                color: Colors.redAccent,
              ),
              title: "Report a bug".text.make(),
              onTap: () {
                launch(
                    'https://github.com/AniketSindhu/find_covid_leads/issues/new');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.app_registration,
                color: Colors.redAccent,
              ),
              title: "Become a moderator".text.make(),
              onTap: () {
                launch('https://forms.gle/kKUtTH5hvtsU9vLS6');
              },
            )
          ]),
        ),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Image.asset(
            'logo.png',
            fit: BoxFit.cover,
            height: 32,
          ),
          centerTitle: true,
        ),
        backgroundColor: Color(0xffDAE0E6),
        body: Column(
          children: [
            20.heightBox,
            VxDevice(
                mobile: MobileFilter(
                  updateLoc: updateLoc,
                  updateRes: updateRes,
                ),
                web: WebFilter(
                  updateLoc: updateLoc,
                  updateRes: updateRes,
                )),
            10.heightBox,
            StreamBuilder(
              stream: queryPost(loc, availableResources[resouce]),
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
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          Post post = Post.fromDocument(
                              snapshot.data.docs[index].data());
                          return VxResponsive(
                            xlarge: VxBox(
                                    child: PostWidget(
                                        post: post, context: context))
                                .shadow
                                .width(context.screenWidth * 0.55)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            large: VxBox(
                                    child: PostWidget(
                                        post: post, context: context))
                                .shadow
                                .width(context.screenWidth * 0.55)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            medium: VxBox(
                                    child: PostWidget(
                                        post: post, context: context))
                                .shadow
                                .width(context.screenWidth * 0.75)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            small: VxBox(
                                    child: PostWidget(
                                        post: post, context: context))
                                .shadow
                                .width(context.screenWidth * 0.9)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            xsmall: VxBox(
                                    child: PostWidget(
                                        post: post, context: context))
                                .shadow
                                .width(context.screenWidth * 0.9)
                                .withDecoration(BoxDecoration(
                                    border: Border.all(width: 0.3),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)))
                                .makeCentered()
                                .py12(),
                            fallback: VxBox(
                                    child: PostWidget(
                                        post: post, context: context))
                                .shadow
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
