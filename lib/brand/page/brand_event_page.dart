import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/brand/widget/brand_event_cell.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BrandEventsPage extends StatelessWidget {
  const BrandEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvider>(builder: (_, provider, __) {
      final List<EventModel>? list = provider.brandBean!.events!.eventList;
      return Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
        child: CardWidget(
            radius: 12.0.r,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: Colours.material_bg,
              ),
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CompanyDetailsItemHeader(
                      isNewIcon: true,
                      iconName: 0xe642,
                      name: 'Events',
                      count: provider.brandBean?.events?.total ?? 0,
                      onTap: (provider.brandBean?.events?.total ?? 0) > 3
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
                                  '${BrandRouder.brandEventListPage}?brandId=${provider.brandBean!.info!.id ?? ''}');
                            }
                          : null),
                  if (list!.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: SizedBox(
                        width: double.infinity,
                        height: 20.h,
                        child: const Text('There are no Events for this brand.'),
                      ),
                    )
                  else
                    ListView.builder(
                      padding: EdgeInsets.only(
                        bottom: 8.h,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length > 3 ? 3 : list.length,
                      itemBuilder: (BuildContext context, int index) {
                        final EventModel models = list[index];
                        return EventCellWidget(model: models);
                      },
                    )
                ],
              ),
            )),
      );
    });
  }
}
