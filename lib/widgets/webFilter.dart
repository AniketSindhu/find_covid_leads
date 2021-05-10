import 'package:auto_size_text/auto_size_text.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:find_covid_leads/methods/getLocations.dart';
import 'package:find_covid_leads/models/cities.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class WebFilter extends StatefulWidget {
  final Function updateLoc;
  final Function updateRes;
  final Function updateResTweet;
  final Function updateLocTweet;
  final int index;
  WebFilter(
      {this.updateLoc,
      this.updateRes,
      this.index,
      this.updateResTweet,
      this.updateLocTweet});
  @override
  _WebFilterState createState() => _WebFilterState();
}

class _WebFilterState extends State<WebFilter> {
  bool showMoreLoc = false;
  bool showMoreRes = false;
  String location = 'All';
  String locTweet;
  List<String> resources = [];
  List<String> availableResources = [
    'Remdesivir',
    'Favipiravir',
    'Oxygen',
    'Ventilator',
    'Plasma',
    'Tocilizumab',
    'ICU',
    'Beds',
    'Food',
    'Ambulance',
    'Fabiflu',
    'Oxygen beds',
    'Concentrators',
    'Oxygen cans',
    'Oxygen cylinder',
    'Other'
  ];
  List<String> availableResourcesTweets = [
    "Icu",
    "Ventilator",
    "Oxygen Bed",
    "Bed",
    "Remdesivir",
    "Favipiravir",
    "Tocilizumab",
    "Plasma",
    "Food",
    "Ambulance",
    "Oxygen Concentrator",
    "Oxygen Cylinder",
    "Covid Test",
    "Helpline"
  ];
  List locations = [];
  int resTweet;
  getLoc() async {
    locations = await getLocations();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        VxBox(
                child: VStack([
          HStack([
            Icon(
              Icons.location_on,
              color: Color(0xff0172c0),
            ),
            5.widthBox,
            "Filter location".text.bold.size(15).make()
          ]),
          10.heightBox,
          locations.isEmpty
              ? CircularProgressIndicator().centered()
              : widget.index == 0
                  ? SearchableDropdown.single(
                      displayClearIcon: false,
                      isExpanded: true,
                      iconEnabledColor: Color(0xff0172c0),
                      value: location,
                      onChanged: (val) {
                        location = val;
                        widget.updateLoc(val);
                        setState(() {});
                      },
                      items: locations
                          .map((e) => DropdownMenuItem(
                                child: '$e'.text.size(15).make().px4(),
                                value: e,
                                onTap: () {
                                  print(e);
                                },
                              ))
                          .toList())
                  : SearchableDropdown.single(
                      displayClearIcon: false,
                      isExpanded: true,
                      hint: 'Select a location'.text.make(),
                      iconEnabledColor: Color(0xff0172c0),
                      value: locTweet,
                      onChanged: (val) {
                        locTweet = val;
                        widget.updateLocTweet(val);
                        setState(() {});
                      },
                      items: cities
                          .map((e) => DropdownMenuItem(
                                child: '$e'.text.size(15).make().px4(),
                                value: e,
                                onTap: () {
                                  print(e);
                                },
                              ))
                          .toList())

          /*  Column(
                  children: [
                    ChipsChoice<int>.single(
                      wrapped: showMoreLoc,
                      value: location,
                      runSpacing: 10,
                      choiceActiveStyle:
                          C2ChoiceStyle(color: Color(0xff0172c0)),
                      onChanged: (val) {
                        location = val;
                        widget.updateLoc(locations[val]);
                      },
                      choiceItems: C2Choice.listFrom<int, dynamic>(
                        source: locations,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        showMoreLoc = !showMoreLoc;
                        setState(() {});
                      },
                      child: HStack([
                        showMoreLoc
                            ? Icon(Icons.arrow_upward_rounded)
                            : Icon(Icons.arrow_downward_rounded),
                        showMoreLoc
                            ? "Show less".text.make()
                            : "Show more".text.make()
                      ]).px8().objectCenterRight(),
                    )
                  ],
                ),*/
        ]).p12())
            .width(context.screenWidth * 0.45)
            .shadowSm
            .white
            .roundedSM
            .make()
            .py4(),
        VxBox(
                child: VStack([
          HStack([
            Icon(
              Icons.local_hospital_rounded,
              color: Color(0xff0172c0),
            ),
            5.widthBox,
            AutoSizeText(
              'What resources you\'re looking for?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              maxLines: 2,
            )
          ]),
          10.heightBox,
/*           DropdownButtonFormField(
              iconEnabledColor: Color(0xff0172c0),
              value: resouce,
              onChanged: (val) {
                resouce = val;
                widget.updateRes(val);
                setState(() {});
              },
              items: availableResources
                  .map((e) => DropdownMenuItem(
                        child: '$e'.text.size(15).make().px4(),
                        value: e,
                        onTap: () {
                          print(e);
                        },
                      ))
                  .toList()) */
          widget.index == 0
              ? ChipsChoice<String>.multiple(
                  wrapped: showMoreRes,
                  spacing: 8,
                  runSpacing: 8,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  choiceActiveStyle: C2ChoiceStyle(color: Color(0xff0172c0)),
                  value: resources,
                  choiceItems: C2Choice.listFrom<String, String>(
                    source: availableResources,
                    value: (i, v) => v,
                    label: (i, v) => v,
                  ),
                  onChanged: (val) {
                    resources = val;
                    widget.updateRes(val);
                    print(resources);
                  },
                )
              : ChipsChoice<int>.single(
                  wrapped: showMoreRes,
                  value: resTweet,
                  runSpacing: 10,
                  choiceActiveStyle: C2ChoiceStyle(color: Color(0xff0172c0)),
                  onChanged: (val) {
                    resTweet = val;
                    widget.updateResTweet(val);
                  },
                  choiceItems: C2Choice.listFrom<int, dynamic>(
                    source: availableResourcesTweets,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                ),
/*           ChipsChoice<int>.multiple(
            wrapped: showMoreRes,
            value: resouce,
            runSpacing: 10,
            choiceActiveStyle: C2ChoiceStyle(color: Color(0xff0172c0)),
            onChanged: (val) {
              widget.updateRes(val);
              resouce = val;
              //setState(() => );
            },
            choiceItems: C2Choice.listFrom<int, String>(
              source: availableResources,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
          ), */
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              showMoreRes = !showMoreRes;
              setState(() {});
            },
            child: HStack([
              showMoreRes
                  ? Icon(Icons.arrow_upward_rounded)
                  : Icon(Icons.arrow_downward_rounded),
              showMoreRes ? "Show less".text.make() : "Show more".text.make()
            ]).px8().objectCenterRight(),
          )
        ]).p12())
            .width(context.screenWidth * 0.45)
            .shadowSm
            .white
            .roundedSM
            .make()
            .py8(),
      ],
      alignment: MainAxisAlignment.spaceEvenly,
      axisSize: MainAxisSize.max,
    );
  }
}
