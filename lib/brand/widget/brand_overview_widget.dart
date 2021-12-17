import 'package:expandable_text/expandable_text.dart';
import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/widget/brand_overview_foundertext_widget.dart';
import 'package:flashinfo/brand/widget/brand_overview_industry_widget.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewWidget extends StatelessWidget {
  final List? titleList;
  final List? dataList;
  final List<Founders>? foundList;
  final BrandBean? brandBean;

  const OverviewWidget(
      {Key? key, this.titleList, this.dataList, this.foundList, this.brandBean})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: ListView.builder(
          padding: EdgeInsets.only(top: 0.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: titleList?.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: index == titleList!.length - 1
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${titleList?[index]}',
                          style: TextStyles.textGray12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gaps.vGap8,
                        Text(
                          '${dataList![index].toString().isEmpty ? '-' : dataList?[index]}',
                          style: TextStyles.textSize12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${titleList?[index]}',
                          style: TextStyles.textGray12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gaps.hGap20,
                        if (index == 4)
                          Expanded(
                              child: FounderAllWidget(
                            tags: foundList,
                          ))
                        else
                          Expanded(
                            child: index == 1
                                ? ExpandableText(
                                    '${dataList![index].toString().isEmpty ? '-' : dataList?[index]}',
                                    //'${dataList?[index].toString().isEmpty?'':dataList?[index]}',
                                    expandText: 'ViewMore',
                                    collapseText: 'ViewLess',
                                    textAlign: TextAlign.end,
                                    linkColor: Colours.text,
                                    linkStyle: TextStyles.textBold12,
                                    style: TextStyles.textSize12,
                                  )
                                // IndustryMoreWidget(
                                //     text: '${dataList?[index]}',
                                //   )
                                : RichText(
                                    maxLines: 1,
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                      text: '',
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '${(brandBean?.summary?.overview?.ipo?.ipoStatus ?? '').isEmpty && dataList![index].toString().isNotEmpty && index == 3 ? '- ' : ''}',
                                          style: TextStyles.textSize12
                                              .copyWith(color: Colours.text),
                                        ),
                                        TextSpan(
                                          text:
                                              '${dataList![index].toString().isEmpty ? '-' : dataList?[index]}',
                                          style: (index == 1 ||
                                                  index == 2 ||
                                                  index == 5)
                                              ? TextStyles.textSize12
                                                  .copyWith(color: Colours.text)
                                              : TextStyles.textSize12.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colours.app_main),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              if (index == 0) {
                                                if ((dataList?[index] as String)
                                                    .isNotEmpty) {
                                                  NavigatorUtils.goWebViewPage(
                                                      context,
                                                      '',
                                                      '${dataList?[index]}');
                                                }
                                              }
                                              if (index == 3) {
                                                final String ipoUrl = brandBean!
                                                        .summary!
                                                        .overview!
                                                        .ipo!
                                                        .stockSymbol!
                                                        .value ??
                                                    '';
                                                if (ipoUrl.isNotEmpty) {
                                                  NavigatorUtils.goWebViewPage(
                                                      context, '', '$ipoUrl');
                                                }
                                              }
                                              if (index == 6) {
                                                if ((dataList?[index] as String)
                                                    .isNotEmpty) {
                                                  if (!(SpUtil.getBool(
                                                          Constant.isLogin,
                                                          defValue: false) ??
                                                      false)) {
                                                    showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            true,
                                                        builder: (_) =>
                                                            LoginToastDialog(
                                                                onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              NavigatorUtils.push(
                                                                  context,
                                                                  LoginRouter
                                                                      .smsLoginPage);
                                                            }));
                                                    return;
                                                  } else {
                                                    NavigatorUtils.push(context,
                                                        '${CompanyRouder.companyFinanceDetail}?index=0&companyId=${brandBean!.info!.id}',
                                                        arguments: brandBean!
                                                            .financials);
                                                  }
                                                }
                                              }
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                      ],
                    ),
            );
          }),
    );
  }
}
