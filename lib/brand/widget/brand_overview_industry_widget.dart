import 'package:flashinfo/res/resources.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class IndustryMoreWidget extends StatefulWidget {
  final String text;

  const IndustryMoreWidget({Key? key, required this.text}) : super(key: key);

  @override
  _IndustryMoreWidgetState createState() => _IndustryMoreWidgetState();
}

class _IndustryMoreWidgetState extends State<IndustryMoreWidget> {
  bool hasMore = false;

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colours.material_bg,
        // alignment: Alignment.centerRight,
        child: widget.text.isNotEmpty?Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                color: Colours.material_bg,
                // width: 180.w,
                child: RichText(
                  maxLines: hasMore ? 9 : 1,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    TextSpan(
                      text: '${widget.text}',
                      style: TextStyles.textGray12,
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    if(widget.text.isNotEmpty && widget.text.length>40)
                    TextSpan(
                      text: 'ViewLess' ,
                      style: TextStyle(
                          color: Colours.text,
                          fontSize: Dimens.font_sp12,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            hasMore = !hasMore;
                          });
                        },
                    )
                  ]),
                ),
              ),
            ),
            if(widget.text.isNotEmpty && widget.text.length>40)
            if (hasMore  )
              Gaps.empty
            else
              GestureDetector(
                onTap: () {
                  setState(() {
                    hasMore = !hasMore;
                  });
                },
                child: Text(
                  '${hasMore ? '' : 'ViewMore'}',
                  style: TextStyles.textBold12.copyWith(color: Colours.text),
                ),
              )
          ],
        ):Text('-',style: TextStyles.text,textAlign: TextAlign.right,));
  }
}
