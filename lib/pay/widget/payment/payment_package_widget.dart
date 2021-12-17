import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PaymentPackageWidget extends StatelessWidget {
  const PaymentPackageWidget(
      {Key? key, this.onTap, required this.payIndex, this.skuIdType})
      : super(key: key);
  final void Function(int)? onTap;
  final SkuIdType? skuIdType;
  final int payIndex;
  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Container(
      width: double.infinity,
      height: 110.h,
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Choose one discount package',
            style: TextStyles.textBold14,
          ),
          Gaps.line,
          Consumer<UserInfoProvider>(builder: (_, userInfoProvider, __) {
            return Row(
              children: userInfoProvider.isVip
                  ? childrenVip(userInfoProvider)
                  : uNchildrenVip(),
            );
          }),
        ],
      ),
    ));
  }

  List<Widget> uNchildrenVip() {
    return <Widget>[
      _itemBtn('Pro', 0),
      _itemBtn('Starter', 1),
      if (skuIdType == SkuIdType.csv)
        _itemBtn('CSV credits', 2)
      else
        _itemBtn('Unlock contact credit', 2)
    ];
  }

  List<Widget> childrenVip(UserInfoProvider userInfoProvider) {
    final UserInfoModel? _userInfoModel = userInfoProvider.userInfoModel;
    return <Widget>[
      if (skuIdType == SkuIdType.csv)
        _itemBtn('CSV credits', 2)
      else
        _itemBtn('Unlock contact credit', 2),
      if (_userInfoModel?.vipData?.vipInfo?.skuSubtype == 11)
        _itemBtn('Pro', 0),
      if (_userInfoModel?.vipData?.vipInfo?.skuSubtype == 12)
        _itemBtn('Starter', 1),
    ];
  }

  Widget _itemBtn(String text, int index) {
    return GestureDetector(
      onTap: () => onTap!(index),
      child: Container(
        height: 30.h,
        constraints: BoxConstraints(maxWidth: 90.w),
        margin: EdgeInsets.only(right: Dimens.gap_dp12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color:
                    payIndex == index ? Colours.app_main : Colours.text_gray_c),
            borderRadius: BorderRadius.circular(3.0.w)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyles.textSize12.copyWith(
              color:
                  payIndex == index ? Colours.app_main : Colours.text_gray_c),
        ),
      ),
    );
  }
}
