import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColleagueCell extends StatelessWidget {
   final ListModel? listModel;
  final Colleagues? colleagues;
  const ColleagueCell({Key? key, required this.colleagues, this.listModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
          showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (_) => LoginToastDialog(onPressed: () {
                    Navigator.pop(context);
                    NavigatorUtils.push(context, LoginRouter.smsLoginPage);
                  }));
          return;
        }

          NavigatorUtils.push(context,
              '${PersonalRouter.personalDetailsPage}?personalId=${listModel?.id??''}');


        // if(colleagues!.info!.entryType==1){
        //   NavigatorUtils.push(context,
        //       '${PersonalRouter.personalDetailsPage}?personalId=${listModel?.id??''}&&isToIndex=${'true'}');
        // }
        //
        // if(colleagues!.info!.entryType==2) {
        //   NavigatorUtils.push(context,
        //       '${BrandRouder.brandDetailPage}?brandId=${listModel?.id??''}');
        // }


      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        color: Colours.material_bg,
        constraints: BoxConstraints(maxWidth: 90.w),
        child: Column(
          children: [
            Container(
              child: LoadBorderImage(
                '${listModel?.avatar ?? ''}',
                width: 70.w,
                height: 70.w,
                radius: 80.r,
                holderImg: 'personnel/personnel',
              ),
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                  color: Colours.line,
                  borderRadius: BorderRadius.all(Radius.circular(80.r))),
              padding:  EdgeInsets.all(3.w),
            ),
            //
            // LoadBorderImage('',
            //     width: 42.w,
            //     height: 42.w,
            //     radius: 42.r,
            //     holderImg: 'brand/brand'),
            Gaps.vGap5,

            // Text(
            //   '${listModel?.name ?? '-'}',
            //   style: TextStyles.textBold14
            //       .copyWith(color: Colours.app_main, fontWeight: FontWeight.bold),
            // ),

            Container(
                constraints: BoxConstraints(maxWidth: 90.w),
                child: Text(
                  '${listModel?.name ?? '-'}',
                  style: TextStyles.textBold14.copyWith(
                      color: Colours.app_main, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),

            Gaps.vGap5,
            Container(
                constraints: BoxConstraints(maxWidth: 95.w),
                child: Text(
                  '${listModel?.position ?? ''}',
                  style: TextStyles.textBold10.copyWith(
                      color: Colours.text, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ))
          ],
        ),
      ),
    );
  }
}
