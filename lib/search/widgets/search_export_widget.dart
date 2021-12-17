import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchExportWidget extends StatelessWidget {
  const SearchExportWidget(
      {Key? key, this.metaModel, this.onTap, this.isShowExport = false})
      : super(key: key);
  final MetaModel? metaModel;
  final void Function()? onTap;
  final bool isShowExport;

  @override
  Widget build(BuildContext context) {
    final int count = metaModel?.pagination?.total ?? 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp8),
            child: Text(
              'Search Companies Results: ($count)',
              style: TextStyles.textGray10,
            ),
          ),
          Visibility(
            visible: !isShowExport || count == 0 ? false : true,
            child: InkWell(
              onTap: () {
                if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ??
                    false)) {
                  AnalyticEventUtil.analyticsUtil
                      .sendAnalyticsEvent('Export_Click_Login');
                  showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => LoginToastDialog(onPressed: () {
                            Navigator.pop(context);
                            NavigatorUtils.push(
                                context, LoginRouter.smsLoginPage);
                          }));
                  return;
                }
                onTap!();
              },
              child: Container(
                alignment: Alignment.center,
                height: 28.0.h,
                child: Text(
                  'Export',
                  style:
                      TextStyles.textGray10.copyWith(color: Colours.app_main),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
