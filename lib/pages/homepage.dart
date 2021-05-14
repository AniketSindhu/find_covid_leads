import 'package:find_covid_leads/pages/twitterResources.dart';
import 'package:find_covid_leads/pages/volunteerPosts.dart';
import 'package:find_covid_leads/widgets/mobileFilter.dart';
import 'package:find_covid_leads/widgets/webFilter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int location = 0;
  String loc = 'All';
  List<String> resouce = [];
  bool showMoreLoc = false;
  bool showMoreResources = false;
  int index = 0;
  int resTweet = 2;
  String locTweet = 'Delhi';
  List<String> availableResourcesTweets = [
    "Home ICU",
    "ICU Bed",
    "Oxygen Bed",
    "Bed",
    "Remdesivir",
    "Favipiravir",
    "Tocilizumab",
    "Plasma",
    "Food",
    "Ambulance",
    "Oxygen Cylinder",
    "Oxygen Concentrator",
    "Covid Test",
    "Helpline",
  ];
  void updateLoc(String val) {
    // getTweets('location', ['resource']);
    setState(() {
      loc = val;
    });
  }

  void updateRes(List<String> val) {
    setState(() {
      resouce = val;
    });
  }

  void updateLocTweet(String val) {
    setState(() {
      locTweet = val;
    });
  }

  void updateResTweet(int val) {
    setState(() {
      resTweet = val;
    });
  }

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.twitter),
                label: 'Twitter resources'),
          ],
          backgroundColor: Color(0xff0172c0),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.cyan[300],
          onTap: (val) {
            index = val;
            setState(() {});
          },
        ),
        key: _scaffoldKey,
        drawer: Drawer(
          child: VStack([
            Image.asset('assets/drawer.png'),
            10.heightBox,
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
              title: "Become a volunteer".text.make(),
              onTap: () {
                launch('https://forms.gle/kKUtTH5hvtsU9vLS6');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.mail, color: Color(0xff0172c0)),
              title: "Contact us".text.make(),
              onTap: () {
                launch('mailto:findcovidleads@gmail.com');
              },
            ),
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
        body: VsScrollbar(
          controller: _controller,
          showTrackOnHover: true, // default false
          isAlwaysShown: true, // default false
          scrollbarFadeDuration: Duration(
              milliseconds: 500), // default : Duration(milliseconds: 300)
          scrollbarTimeToFade: Duration(
              milliseconds: 800), // default : Duration(milliseconds: 600)
          style: VsScrollbarStyle(
            hoverThickness: 10.0, // default 12.0
            radius: Radius.circular(10), // default Radius.circular(8.0)
            thickness: 10.0, // [ default 8.0 ]
            color: Color(0xff0172c0), // default ColorScheme Theme
          ),
          child: Column(
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
                    'assets/logo.png',
                    height: 40,
                  ).centered(),
                ],
              ),
              10.heightBox,
              "We are a group of relentless volunteers on a mission to save lives by finding verified COVID resources."
                  .text
                  .center
                  .medium
                  .size(15)
                  .make()
                  .px8(),
              10.heightBox,
              VxDevice(
                  mobile: MobileFilter(
                    updateLoc: updateLoc,
                    updateRes: updateRes,
                    updateResTweet: updateResTweet,
                    updateLocTweet: updateLocTweet,
                    index: index,
                  ),
                  web: WebFilter(
                    updateLoc: updateLoc,
                    updateRes: updateRes,
                    updateResTweet: updateResTweet,
                    updateLocTweet: updateLocTweet,
                    index: index,
                  )),
              5.heightBox,
              "This information is crowd sourced and we are continuously trying to verify the information posted on CovidLead.\n🚨 Please beware of fraudsters 🚨"
                  .text
                  .center
                  .make()
                  .px12()
                  .py8(),
              10.heightBox,
              ElevatedButton(
                onPressed: () {
                  launch(
                      'https://docs.google.com/document/d/1AnLQg7C6f-bRtpJoaEMHiOApXIE0FNq9rF8bMHhHn2I/edit?usp=sharing');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.fileAlt,
                      color: Colors.white,
                      size: 20,
                    ).px8(),
                    Text(
                      "Important covid links/resources",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ).pOnly(right: 8),
                  ],
                ).py8(),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff0172c0))),
              ),
              index == 0
                  ? VolunteerPost(
                      loc: loc,
                      resouce: resouce,
                      controller: _controller,
                    )
                  : TwitterResources(
                      location: locTweet,
                      resource: resTweet == null
                          ? resTweet
                          : availableResourcesTweets[resTweet].toLowerCase()),
            ],
          ).scrollVertical(controller: _controller),
        ));
  }
}
