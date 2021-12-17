import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FounderAllWidget extends StatefulWidget {
  final List<Founders>? tags;

  const FounderAllWidget({Key? key, this.tags}) : super(key: key);

  @override
  _FounderAllWidgetState createState() => _FounderAllWidgetState();
}

class _FounderAllWidgetState extends State<FounderAllWidget> {
  bool hasMore = false;

  List<TextSpan> getAllSpan(
      List<Founders>? tags, bool hasmore, Function callBack) {
    final List<TextSpan> spans = [];

    for (int i = 0; i < tags!.length; i++) {
      final Founders founders = tags[i];
      spans.add(TextSpan(
        text: '${founders.name} ${i == tags.length - 1 ? '' : ','}',
        style: TextStyle(
            color: Colours.app_main,
            fontSize: Dimens.font_sp12,
            fontWeight: FontWeight.bold),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            NavigatorUtils.pushResult(context,
                '${PersonalRouter.personalDetailsPage}?personalId=${founders.id}',
                (value) {
              print(value);
            });
          },
      ));
    }
    // if (tags.length>4)

    // spans.add(
    //     TextSpan(
    //   text:  'ViewLess' ,
    //   style: TextStyle(
    //       color: Colours.text,
    //       fontSize: Dimens.font_sp12,
    //       fontWeight: FontWeight.bold),
    //   recognizer: TapGestureRecognizer()
    //     ..onTap = () {
    //       callBack();
    //     },
    // ));

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colours.material_bg,
        // alignment: Alignment.centerRight,
        child: widget.tags!.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                     Container(
                      color: Colours.material_bg,
                      // width: 180.w,
                      child: RichText(
                        maxLines: hasMore ? 20 : 2,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            children: getAllSpan(widget.tags, hasMore, () {
                          setState(() {
                            hasMore = !hasMore;
                          });
                        })),
                      ),
                    ),

                  Visibility(
                      visible: widget.tags!.length > 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            hasMore = !hasMore;
                          });
                        },
                        child: Text(
                          '${hasMore ? 'ViewLess' : 'ViewMore'}',
                          style: TextStyles.textBold12
                              .copyWith(color: Colours.text),
                        ),
                      ))
                ],
              )
            : Text(
                '-',
                style: TextStyles.text,
                textAlign: TextAlign.right,
              ));
  }
}
