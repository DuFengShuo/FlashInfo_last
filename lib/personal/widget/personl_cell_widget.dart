import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/hight_light_text_widget.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalCellWidget extends StatelessWidget {
  const PersonalCellWidget(
      {Key? key,
      this.peoplesModel,
      this.collectSuccessful,
      this.onTap,
      this.highlightText = ''})
      : super(key: key);
  final PeoplesModel? peoplesModel;
  final void Function(bool)? collectSuccessful;
  final void Function()? onTap;
  final String? highlightText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16,
          bottom: Dimens.gap_v_dp8,
        ),
        child: MyCard(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp10),
          child: _buildContent(context),
        )),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colours.material_bg,
            border: Border.all(
                color: Colours.bg_color,
                width: 0.6.h,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(3), // 设置四周圆角
            image: DecorationImage(
              fit: BoxFit.fill,
              image: ImageUtils.getImageProvider(peoplesModel?.avatar ?? '',
                  holderImg: 'personnel/personnel'),
            ),
          ),
          width: 58.0.w,
          height: 58.0.w,
        ),
        Gaps.hGap10,
        Expanded(
            child: Container(
          color: Colours.material_bg,
          height: 58.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: Screen.width(context) - 170.w,
                    ),
                    child: HighlightTextWidget(
                        name: peoplesModel?.name ?? '-',
                        highlightText: highlightText ?? ''),
                  ),
                  Gaps.hGap4,
                  // Visibility(
                  //   visible: peoplesModel?.countryImg?.imgName != null &&
                  //       (peoplesModel?.countryImg?.imgName ?? '').isNotEmpty,
                  //   child: Consumer<CommonProvider>(
                  //     builder: (_, commonProvider, __) {
                  //       final Map<String, String>? nationalFlag =
                  //           commonProvider.initializeModel?.icon?.nationalFlag;
                  //       return LoadImage(
                  //         nationalFlag?[peoplesModel?.countryImg?.imgName] ??
                  //             '',
                  //         width: 18.0.w,
                  //         height: 12.0.h,
                  //         fit: BoxFit.fitHeight,
                  //       );
                  //     },
                  //   ),
                  // ),
                  const Spacer(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: true,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 150.w,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 10.0.w,
                        ),
                        child: Text(
                          peoplesModel?.position ?? '-',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.textGray10,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: peoplesModel?.companyModel == null ||
                            peoplesModel?.companyModel?.name == null ||
                            peoplesModel!.companyModel!.name!.isEmpty ||
                            peoplesModel?.position == null ||
                            peoplesModel!.position!.isEmpty
                        ? false
                        : true,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0.w),
                      child: Text(
                        '|',
                        style: TextStyles.textGray10
                            .copyWith(color: Colours.text_gray_c),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      peoplesModel?.companyModel?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textGray10,
                    ),
                  )
                ],
              ),
              Text(
                peoplesModel?.education?.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.textGray10,
              ),
            ],
          ),
        )),
        Gaps.hGap8,
        // InkWell(
        //   onTap: () => _showFavouritesDialog(context),
        //   child: IconFont(
        //       name: 0xe611,
        //       size: 16.sp,
        //       color: (peoplesModel?.isCollect ?? false)
        //           ? Colours.app_main
        //           : Colours.unselected_item_color),
        // ),
        Gaps.hGap5,
      ],
    );
  }

  // void _showFavouritesDialog(BuildContext context) {
  //   if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
  //     showDialog<void>(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (_) => LoginToastDialog(onPressed: () {
  //               Navigator.pop(context);
  //               NavigatorUtils.push(context, LoginRouter.smsLoginPage);
  //             }));
  //     return;
  //   }
  //   if (peoplesModel?.isCollect == true) {
  //     showElasticDialog<void>(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return CancelGroupPage(
  //           indexType: 1,
  //           relatedTd: peoplesModel?.id,
  //           collectCancel: collectSuccessful,
  //         );
  //       },
  //     );
  //   } else {
  //     showElasticDialog<void>(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return GroupDialogPage(
  //             indexType: 1,
  //             relatedTd: peoplesModel?.id,
  //             collectSuccessful: collectSuccessful);
  //       },
  //     );
  //   }
  // }
}
