import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductHeaderWidget extends StatefulWidget {
  final String? iconName;
  final String? name;
  final String? webUrl;
  const ProductHeaderWidget({Key? key, this.iconName, this.name, this.webUrl}) : super(key: key);

  @override
  _ProductHeaderWidgetState createState() => _ProductHeaderWidgetState();
}

class _ProductHeaderWidgetState extends State<ProductHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(top: 90.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Container(
            child: LoadBorderImage(
              '${widget.iconName}',
              width: 60.w,
              height: 60.w,
              radius: 10.r,
              holderImg: 'product/product',
            ),
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
                color: Colours.material_bg,
                borderRadius: BorderRadius.all(
                    Radius.circular(10.r))),
            padding: const EdgeInsets.all(5),
          ),
         Gaps.hGap12,
          Container(
            color: Colors.transparent,
            height: 70.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Container(
                  constraints: BoxConstraints(
                    maxWidth: Screen.width(context)-120.w
                  ),
                  child: Text(
                    '${widget.name!.isEmpty?'-':widget.name}',
                    style: TextStyles.textBold18
                        .copyWith(color: Colours.material_bg),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Gaps.vGap16,
                Row(
                  children: [
                    IconFont(
                      name: 0xe678,
                      color: Colours.material_bg,
                      size: 18.sp,
                      isNewIcon: true,
                    ),
                    Gaps.hGap5,
                    Text(
                      '${widget.webUrl!.isEmpty?'-':widget.webUrl}',
                      style: TextStyles.textSize13
                          .copyWith(color: Colours.material_bg),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
