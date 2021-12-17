import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/pay/iview/pay_iview.dart';
import 'package:flashinfo/pay/model/pay_ments_list_bean.dart';
import 'package:flashinfo/pay/page/price_list_dialog.dart';
import 'package:flashinfo/pay/presenter/payments_presenter.dart';
import 'package:flashinfo/pay/widget/pay_list_item_widget.dart';
import 'package:flashinfo/pay/widget/usage_item_widget.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PayListPage extends StatefulWidget {
  const PayListPage({Key? key}) : super(key: key);

  @override
  _PayListPageState createState() => _PayListPageState();
}

class _PayListPageState extends State<PayListPage>
    with BasePageMixin<PayListPage, PowerPresenter>
    implements PaymentsIMvpView {
  @override
  BaseListProvider<PayMentsListModel> paymentsListModelProvider =
      BaseListProvider<PayMentsListModel>();

  late PaymentsPresenter _paymentsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _paymentsPresenter = PaymentsPresenter();
    powerPresenter.requestPresenter([_paymentsPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        _paymentsPresenter.onRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<PayMentsListModel>>(
            create: (_) => paymentsListModelProvider),
      ],
      child: Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: const MyAppBar(
          centerTitle: 'Usage detail',
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 160.h,
              padding: EdgeInsets.only(
                top: Dimens.gap_v_dp16,
                left: Dimens.gap_dp16,
                right: Dimens.gap_dp16,
                bottom: Dimens.gap_v_dp10,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ImageUtils.getAssetImage(
                      'pay/business',
                    )),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Usage Amount',
                    style: TextStyles.textBold17
                        .copyWith(color: Colours.material_bg),
                  ),
                  Gaps.vGap5,
                  Expanded(
                      child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: Dimens.gap_v_dp16, bottom: Dimens.gap_v_dp10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: ImageUtils.getAssetImage(
                            'pay/usage',
                          )),
                    ),
                    child:
                        Consumer<UserInfoProvider>(builder: (_, provider, __) {
                      return Row(
                        children: [
                          UsageItemWidget(
                            title: 'Contacts credit',
                            balanceVip: provider.userInfoModel?.vipData
                                    ?.balanceUnlock?.balanceVip ??
                                0,
                            balanceQuantity: provider.userInfoModel?.vipData
                                    ?.balanceUnlock?.balanceQuantity ??
                                0,
                            onPressed: () =>
                                _showPackageDialog(SkuIdType.contact),
                          ),
                          UsageItemWidget(
                            title: 'CSV credit',
                            balanceVip: provider.userInfoModel?.vipData
                                    ?.balanceExport?.balanceVip ??
                                0,
                            balanceQuantity: provider.userInfoModel?.vipData
                                    ?.balanceExport?.balanceQuantity ??
                                0,
                            onPressed: () => _showPackageDialog(SkuIdType.csv),
                          ),
                        ],
                      );
                    }),
                  ))
                ],
              ),
            ),
            Expanded(
              child: Consumer<BaseListProvider<PayMentsListModel>>(
                  builder: (_, provider, __) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp10),
                  child: DeerListView(
                    key: const Key('usage_list'),
                    itemCount: provider.list.length,
                    stateType: provider.stateType,
                    onRefresh: _paymentsPresenter.onRefresh,
                    loadMore: _paymentsPresenter.loadMore,
                    hasMore: provider.hasMore,
                    totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                    itemBuilder: (_, index) {
                      final PayMentsListModel? model = provider.list[index];
                      return PayListItemWidget(
                        payMentsListModel: model,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showPackageDialog(SkuIdType skuIdType) {
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PriceListDialog(
            onPressed: () async {
              await _paymentsPresenter.onRefresh();
            },
            skuIdType: skuIdType);
      },
    );
  }
}
