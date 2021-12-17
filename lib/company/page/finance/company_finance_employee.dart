import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinanceEmployee extends StatelessWidget {
  final List<PeoplesModel> listData;

  const FinanceEmployee({Key? key, required this.listData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
       physics: const NeverScrollableScrollPhysics(),
      itemCount: listData.length>6?6:listData.length,
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 10.w,mainAxisExtent: 140.h),
       padding:   EdgeInsets.only(top: 15.h),
      itemBuilder: (BuildContext context, int index) {
        return _employeeItem(listData[index], context);
      },
    );
  }
}

Widget _employeeItem(PeoplesModel model, BuildContext context) {
  return GestureDetector(
    onTap: () => NavigatorUtils.push(context,
        '${PersonalRouter.personalDetailsPage}?personalId=${model.id}'),
    child:  Container(
      color: Colours.material_bg,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colours.border_grey,
                borderRadius: BorderRadius.all(Radius.circular(40.r))),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 35.0.r,
                backgroundColor: Colours.text_gray_c,
                backgroundImage: ImageUtils.getImageProvider(
                  model.avatar ?? '',
                  holderImg: 'personnel/personnel',
                ),
              ),
            ),
          ),
          Gaps.vGap5,
          Text(
            model.position ?? '',
            style: TextStyles.textBold10.copyWith(
                color: Colours.text, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Gaps.vGap5,
          Text(
            model.name ?? '',
            style: TextStyles.textSize14.copyWith(
                color: Colours.app_main, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // const Expanded(child: Gaps.empty)
        ],
      ),
    ),
  );
}
