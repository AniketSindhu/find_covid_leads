import 'package:auto_size_text/auto_size_text.dart';
import 'package:big_numbers/big_numbers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_covid_leads/methods/upvote.dart';
import 'package:find_covid_leads/models/post.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatefulWidget {
  final Post post;
  final BuildContext context;
  PostWidget({this.post, this.context});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool upvoted = false;
  bool downvoted = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: VxBox(
                        child: VStack(
                  [
                    InkWell(
                      onTap: () {
                        if (!upvoted) {
                          upvoted = true;
                          if (downvoted) {
                            downvoted = false;
                            upvote(2, widget.post);
                          } else {
                            upvote(1, widget.post);
                          }
                        } else {
                          upvoted = false;
                          downvote(1, widget.post);
                        }
                        setState(() {});
                      },
                      child: Icon(
                        Icons.thumb_up_alt,
                        color: upvoted ? Color(0xff0172c0) : Colors.grey,
                        size: 20,
                      ),
                    ),
                    3.heightBox,
                    AutoSizeText(
                      simplifyNumber(widget.post.upvotes.toString()),
                      maxLines: 1,
                    ),
                    3.heightBox,
                    InkWell(
                      onTap: () {
                        if (!downvoted) {
                          downvoted = true;
                          if (upvoted) {
                            upvoted = false;
                            downvote(2, widget.post);
                          } else {
                            downvote(1, widget.post);
                          }
                        } else {
                          downvoted = false;
                          upvote(1, widget.post);
                        }
                        setState(() {});
                      },
                      child: Icon(
                        Icons.thumb_down_alt,
                        color: downvoted ? Colors.blueGrey : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ],
                  axisSize: MainAxisSize.max,
                  alignment: MainAxisAlignment.start,
                ).py8().p4().centered())
                    .gray100
                    .make()),
            Flexible(
              flex: 12,
              fit: FlexFit.tight,
              child: VStack(
                [
                  Row(
                    children: [
                      widget.post.postedBy.text.bold.make(),
                      timeago.format(widget.post.time).text.bold.make()
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                  ),
                  SizedBox(height: 10),
                  widget.post.image == null
                      ? Container().h(0).w(0)
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: context.screenHeight * 0.5,
                              maxWidth: double.infinity,
                              minWidth: 100,
                              minHeight: 200),
                          child: CachedNetworkImage(
                            imageUrl: widget.post.image,
                            placeholder: (context, url) => VxBox()
                                .width(double.infinity)
                                .roundedSM
                                .height(context.screenHeight * 0.9)
                                .gray500
                                .make()
                                .shimmer(),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(Icons.error);
                            },
                          ),
                        ).centered(),
                  SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 10,
                    spacing: 10,
                    children: widget.post.resources
                        .map((e) => Chip(
                              label: '$e'.toString().text.white.make(),
                              backgroundColor: Color(0xff0172c0),
                            ))
                        .toList(),
                  ).objectBottomLeft(),
                  SizedBox(height: 10),
                  "Location: ${widget.post.location}"
                      .text
                      .bold
                      .size(16)
                      .make()
                      .objectCenterLeft(),
                  widget.post.description != null ||
                          widget.post.description.trim().length != 0
                      ? SizedBox(height: 10)
                      : Container(),
                  widget.post.description != null ||
                          widget.post.description.trim().length != 0
                      ? Text(
                          widget.post.description,
                          style: TextStyle(fontSize: 14),
                        ).objectCenterLeft()
                      : Container()
                ],
                crossAlignment: CrossAxisAlignment.center,
              ).p12(),
            ),
          ],
        ),
      ],
    );
  }
}
