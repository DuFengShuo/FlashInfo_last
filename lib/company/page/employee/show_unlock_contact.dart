import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/base_bottom_sheet.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowUnlockContact extends StatelessWidget {
  const ShowUnlockContact(
      {Key? key,
      this.mobile,
      this.email,
      this.avatar,
      this.name,
      this.position, required this.id})
      : super(key: key);
  final String? mobile;
  final String? email;
  final String? avatar;
  final String? name;
  final String? position;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      height: 380.h,
      children: [
        Text(
          'Contact',
          style: TextStyles.textBold18,
        ),
        Gaps.vGap18,
        Row(children: [
          Container(
            decoration: BoxDecoration(
                color: Colours.border_grey,
                borderRadius: BorderRadius.all(Radius.circular(24.0.r))),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 21.0.r,
                backgroundColor: Colours.text_gray_c,
                backgroundImage: ImageUtils.getImageProvider(
                  '${avatar ?? ''}',
                  holderImg: 'personnel/personnel',
                ),
              ),
            ),
          ),
          // LoadBorderImage(model?.avatar ?? '',
          //     width: 58.w, height: 58.h, holderImg: 'personnel/personnel'),
          Gaps.hGap10,
          Expanded(child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GestureDetector(
                onTap: (){
                  NavigatorUtils.push(context,
                      '${PersonalRouter.personalDetailsPage}?personalId=$id');
                },
                child:  Text(
                  name!.isEmpty?'-':name??'',
                  style: TextStyles.textBold14.copyWith(color: Colours.app_main),
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),

              Gaps.vGap10,
              Text(
                position!.isEmpty?'-':position??'',
                style: TextStyles.textGray10,
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          ))

        ]),
        Gaps.vGap10,
        Gaps.vGap10,
        Gaps.vGap8,
        Visibility(
          visible: mobile!.isNotEmpty,
          child: Row(
            children: [
              Gaps.hGap10,
              IconFont(
                name: 0xe629,
                color: Colours.text_gray_c,
                size: 16.sp,
              ),
              Gaps.hGap10,
              Expanded(child:   Text(
                mobile ?? '-',
                style: TextStyles.textSize14.copyWith(color: mobile!.isNotEmpty?Colours.app_main: Colours.text),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
            ,
              const Spacer(),
              GestureDetector(
                onTap: () => Utils.launchTelURL(mobile ?? ''),
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                      color: Colours.app_main,
                      borderRadius: BorderRadius.all(Radius.circular(44.w))),
                  child: IconFont(
                    name: 0xe625,
                    color: Colours.material_bg,
                    size: 18.sp,
                  ),
                ),
              ),
              Gaps.hGap10,
            ],
          ),
        ),
        Gaps.vGap10,
        Gaps.line,
        Gaps.vGap10,
        Visibility(
          visible: email!.isNotEmpty,
          child: Row(
            children: [
              Gaps.hGap10,
              IconFont(
                name: 0xe62a,
                color: Colours.text_gray_c,
                size: 15.sp,
              ),
              Gaps.hGap10,
              Expanded(child:   Text(
                email ?? '',
                style: TextStyles.textSize14.copyWith(color: Colours.text),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),),

              const Spacer(),
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                    color: Colours.bg_color,
                    borderRadius: BorderRadius.all(Radius.circular(44.w))),
                child: IconFont(
                  name: 0xe62a,
                  color: Colours.material_bg,
                  size: 14.sp,
                ),
              ),
              Gaps.hGap10,
            ],
          ),
        ),

        const Spacer(),
        // Gaps.vGap24,
        GestureDetector(
          onTap: () {
            NavigatorUtils.goBack(context);
          },
          child: Container(
            alignment: Alignment.center,
            height: 44.h,
            width: Screen.width(context),
            margin: EdgeInsets.only(left: 16.w, right: 16.w),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colours.border_grey),
                borderRadius: BorderRadius.all(Radius.circular(44.h))),
            child: Text(
              'Cancel',
              style: TextStyles.text,
            ),
          ),
        )
      ],
    );
  }
}
