import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_unlock_view.dart';
import 'package:flutter/material.dart';

class CompanyFinanceNodata extends StatelessWidget {
  const CompanyFinanceNodata(
      {Key? key,
      this.userInfoModel,
      this.isVip = false,
      this.isListNodata = false,
      this.onTap, this.firstData, this.lastData})
      : super(key: key);
  final UserInfoModel? userInfoModel;
  final bool? isVip;
  final bool? isListNodata;
  final void Function()? onTap;
  final String? firstData;
  final String? lastData;

  @override
  Widget build(BuildContext context) {
    return


           Column(
                children: [
                  Gaps.vGap50,
                  const LoadAssetImage(
                    'state/company',
                    width: 120,
                  ),
                  Gaps.vGap15,
                  const Text('No data')
                ],
              );
  }
}
