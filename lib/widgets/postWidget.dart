import 'package:auto_size_text/auto_size_text.dart';
import 'package:big_numbers/big_numbers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_covid_leads/models/post.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

VxBox postWidget(Post post, BuildContext context) {
  return VxBox(
      child: Column(
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
                  Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                  3.heightBox,
                  AutoSizeText(
                    simplifyNumber(post.upvotes.toString()),
                    maxLines: 1,
                  ),
                  3.heightBox,
                  Icon(
                    Icons.thumb_down_alt_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
                axisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.start,
              ).p4().centered())
                  .gray100
                  .make()),
          Flexible(
            flex: 12,
            fit: FlexFit.tight,
            child: VStack(
              [
                Row(
                  children: [
                    post.postedBy.text.bold.make(),
                    timeago.format(post.time).text.bold.make()
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                ),
                SizedBox(height: 10),
                post.image == null
                    ? Container().h(0).w(0)
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: context.screenHeight * 0.9,
                            maxWidth: double.infinity,
                            minWidth: 100,
                            minHeight: 200),
                        child: CachedNetworkImage(
                          imageUrl: post.image,
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
                  children: post.resources
                      .map((e) => Chip(
                            label: '$e'.toString().text.white.make(),
                            backgroundColor: Colors.redAccent,
                          ))
                      .toList(),
                ).objectBottomLeft(),
                SizedBox(height: 10),
                "Location: ${post.location}"
                    .text
                    .bold
                    .size(16)
                    .make()
                    .objectCenterLeft(),
                post.description != null || post.description.trim().length != 0
                    ? SizedBox(height: 10)
                    : Container(),
                post.description != null || post.description.trim().length != 0
                    ? ReadMoreText(
                        post.description,
                        trimLines: 2,
                        colorClickableText: Colors.redAccent,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'read more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ).objectCenterLeft()
                    : Container()
              ],
              crossAlignment: CrossAxisAlignment.center,
            ).p12(),
          ),
        ],
      ),
    ],
  )).shadow;
}
