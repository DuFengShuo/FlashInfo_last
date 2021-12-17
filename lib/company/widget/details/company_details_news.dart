import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';

import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'company_details_item_header.dart';

class CompanyDetailsNews extends StatelessWidget {
  const CompanyDetailsNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvider>(builder: (_, provider, __) {
      final BrandBean? brandBean = provider.brandBean;
      final List<NewsModel>? list = provider.brandBean!.news!.newsList;
      return Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
          child: CardWidget(
              radius: 12.0.r,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  color: Colours.material_bg,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.gap_dp16,
                      ),
                      child: CompanyDetailsItemHeader(
                          iconName: 0xe66e,
                          name: 'News',
                          count: provider.brandBean?.news?.total ?? 0,
                          onTap: (provider.brandBean?.news?.total ?? 0) > 3
                              ? () {
                                  if (!(SpUtil.getBool(Constant.isLogin,
                                          defValue: false) ??
                                      false)) {
                                    showDialog<void>(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (_) =>
                                            LoginToastDialog(onPressed: () {
                                              Navigator.pop(context);
                                              NavigatorUtils.push(context,
                                                  LoginRouter.smsLoginPage);
                                            }));
                                    return;
                                  }
                                  NavigatorUtils.push(context,
                                      '${CompanyRouder.companyNewsPage}?companyId=${brandBean!.info!.id}');
                                }
                              : null),
                    ),
                    Gaps.line,
                    if (list!.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16.w, right: 16.w, top: 16.h, bottom: 8.h),
                        child: SizedBox(
                          width: double.infinity,
                          height: 20.h,
                          child:
                              const Text('There are no News for this brand.'),
                        ),
                      )
                    else


                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimens.gap_dp10,
                        ),
                        child: SizedBox(
                            width: double.infinity,
                            // height: 60.h * list.length,
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 8.h),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: list.length > 3 ? 3 : list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final NewsModel model = list[index];
                                  return _detailsNews(context, model, index);
                                },
                              ),
                            )),
                      ),
                    Gaps.vGap17,
                  ],
                ),
              )));
    });
  }

  Widget _detailsNews(BuildContext context, NewsModel? model, int index) {
    return GestureDetector(
      onTap: () => _launchWebURL('', model?.link ?? '', context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
            child: Text(
              model!.title.toString(),
              style:
                  TextStyles.textBold14.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Text(
          //   'News·${model.publishTime} | ${model.source}',
          //   style: TextStyles.textGray10,
          //   maxLines: 1,
          //   overflow: TextOverflow.ellipsis,
          // ),

          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${model.source}',
                    style: TextStyles.textGray12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gaps.hGap8,
                Text(
                  '${model.publishTime}',
                  style: TextStyles.textGray12,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Visibility(
            visible: index == 2 ? false : true,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
              child: Gaps.line,
            ),
          )
        ],
      ),
    );
  }

  void _launchWebURL(String title, String url, BuildContext context) {
    if (Device.isMobile) {
      NavigatorUtils.goWebViewPage(context, title, url);
    } else {
      Utils.launchWebURL(url);
    }
  }
}
