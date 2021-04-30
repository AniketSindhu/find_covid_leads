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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int location = 0;
  String loc = 'All';
  String resouce = 'All';
  bool showMoreLoc = false;
  bool showMoreResources = false;
  void updateLoc(String val) {
    setState(() {
      loc = val;
    });
  }

  void updateRes(String val) {
    setState(() {
      resouce = val;
    });
  }

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: VStack([
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.bug_report,
                color: Color(0xff0172c0),
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
                color: Color(0xff0172c0),
              ),
              title: "Become a moderator".text.make(),
              onTap: () {
                launch('https://forms.gle/kKUtTH5hvtsU9vLS6');
              },
            )
          ]),
        ),
/*         appBar: AppBar(
          backgroundColor: Color(0xff0172c0),
          title: Image.asset(
            'logo.png',
            fit: BoxFit.cover,
            height: 32,
          ),
          centerTitle: true,
        ), */
        backgroundColor: Color(0xffDAE0E6),
        body: Column(
          children: [
            15.heightBox,
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(Icons.menu, color: Color(0xff0172c0))
                      .objectCenterLeft()
                      .p12(),
                ).objectTopLeft(),
                Image.asset(
                  'assets/logo2.png',
                  height: 40,
                ).centered(),
              ],
            ),
            10.heightBox,
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
