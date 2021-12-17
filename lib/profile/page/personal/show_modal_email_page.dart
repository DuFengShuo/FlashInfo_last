import 'package:flashinfo/profile/widget/input_text_page.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../profile_router.dart';

class ShowModalEmailPage extends StatefulWidget {
  const ShowModalEmailPage({Key? key}) : super(key: key);

  @override
  _ShowModalEmailPageState createState() => _ShowModalEmailPageState();
}

class _ShowModalEmailPageState extends State<ShowModalEmailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 230.h,
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have not bound an email address',
              style:
                  TextStyles.textBold16.copyWith(fontWeight: FontWeight.bold),
            ),
            Gaps.vGap20,
            Text(
              'After binding the e-mail address, you can not only log in by e-mail, but also learn more industry trends through e-mail',
              style: TextStyles.textSize12,
            ),
            const Expanded(child: Gaps.empty),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () => NavigatorUtils.goBack(context),
                    child: Container(
                      alignment: Alignment.center,
                      height: 35.h,
                      decoration: BoxDecoration(
                        border:
                            new Border.all(color: Colours.app_main, width: 1),
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                      ),
                      child: Text(
                        'Not consider',
                        style: TextStyles.textSize10
                            .copyWith(color: Colours.app_main),
                      ),
                    ),
                  ),
                ),
                Gaps.hGap20,
                Expanded(
                  flex: 7,
                  child: MyButton(
                    minHeight: 35.h,
                    text: 'Bind immediately',
                    onPressed: () {
                      NavigatorUtils.goBack(context);
                      _goInputTextPage(
                        context,
                        true,
                        'Enter email address',
                        'Email',
                        '',
                        (result) {
                          Toast.show(result.toString());
                        },
                        otherText:
                            'The system will send an email containing a verification code to the filled mailbox',
                        title: 'Mailbox binding',
                        pageType: 'bindEmail',
                      );
                    },
                    fontSize: 12.sp,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _goInputTextPage(
    BuildContext context,
    bool isNext,
    String titleText,
    String hintText,
    String content,
    Function(Object?) function, {
    TextInputType? keyboardType,
    String? otherText,
    String? title,
    String? pageType,
    int? areaCode,
  }) {
    NavigatorUtils.pushResult(context, ProfileRouter.inputTextPage, function,
        arguments: InputTextPageArgumentsData(
          isNext: isNext,
          title: title,
          titleText: titleText,
          hintText: hintText,
          content: content,
          otherText: otherText,
          keyboardType: keyboardType,
          pageType: pageType,
          areaCode: areaCode,
        ));
  }
}
