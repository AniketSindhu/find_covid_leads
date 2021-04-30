import 'package:chips_choice/chips_choice.dart';
import 'package:find_covid_leads/methods/getLocations.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class WebFilter extends StatefulWidget {
  final Function updateLoc;
  final Function updateRes;
  WebFilter({this.updateLoc, this.updateRes});
  @override
  _WebFilterState createState() => _WebFilterState();
}

class _WebFilterState extends State<WebFilter> {
  bool showMoreLoc = false;
  bool showMoreRes = false;
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
  List locations = [];
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
            "Filter Location".text.bold.size(15).make()
          ]),
          10.heightBox,
          locations.isEmpty
              ? CircularProgressIndicator().centered()
              : Column(
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
                ),
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
              color: Color(0xff0172c0),
            ),
            5.widthBox,
            "Filter Resources".text.bold.size(15).make()
          ]),
          10.heightBox,
          ChipsChoice<int>.single(
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
          ),
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
            .px8(),
      ],
      alignment: MainAxisAlignment.spaceEvenly,
      axisSize: MainAxisSize.max,
    );
  }
}
