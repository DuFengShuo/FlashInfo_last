import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/pay/iview/pay_iview.dart';
import 'package:flashinfo/pay/model/go_pay_bean.dart';
import 'package:flashinfo/pay/presenter/pay_presenter.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/widgets/base_dialog.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:convert' as convert;

class PriceListDialog extends StatefulWidget {
  const PriceListDialog({Key? key, this.onPressed, required this.skuIdType})
      : super(key: key);
  final void Function()? onPressed;
  final SkuIdType skuIdType;
  @override
  _PriceListDialogState createState() => _PriceListDialogState();
}

class _PriceListDialogState extends State<PriceListDialog>
    with BasePageMixin<PriceListDialog, PowerPresenter>
    implements PayIMvpView {
  late int _seletedIndex = 0;
  late PayManger payManger = PayManger();
  late PayPresenter _payPresenter;

  Map<String, String> _priceList = <String, String>{};
  @override
  GoPayModel payModel = GoPayModel('', '', false);
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _payPresenter = PayPresenter();
    powerPresenter.requestPresenter([_payPresenter]);
    return powerPresenter;
  }

  ///获取订单号
  Future _getOrderOn(int quantity) async {
    final PaymentsParams paymentsParams = PaymentsParams();
    paymentsParams.paymentType = Device.isIOS
        ? PaymentType.IOS.toString().replaceAll('PaymentType.', '')
        : PaymentType.GOOGLE.toString().replaceAll('PaymentType.', '');
    paymentsParams.orderType = (widget.skuIdType == SkuIdType.pro ||
            widget.skuIdType == SkuIdType.starter)
        ? 2
        : 1;
    paymentsParams.skuId = Device.isAndroid &&
            (widget.skuIdType == SkuIdType.pro ||
                widget.skuIdType == SkuIdType.starter)
        ? (widget.skuIdType == SkuIdType.pro ? 5 : 6)
        : widget.skuIdType.index + 1;
    paymentsParams.quantity = quantity;
    await _payPresenter.getOrderOn(paymentsParams,
        success: (GoPayModel? model) {

      payModel = model!;
      // payManger.restorePurchases();
      if (payManger.products.isNotEmpty) {
        final ProductDetails productDetails = payManger.products[_seletedIndex];
        payManger.goPay(
            productDetails,
            widget.skuIdType == SkuIdType.csv ||
                widget.skuIdType == SkuIdType.contact);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        final PaymentsParams paymentsParams = PaymentsParams();
        paymentsParams.paymentType = Device.isIOS
            ? PaymentType.IOS.toString().replaceAll('PaymentType.', '')
            : PaymentType.GOOGLE.toString().replaceAll('PaymentType.', '');
        paymentsParams.skuId = Device.isAndroid &&
                (widget.skuIdType == SkuIdType.pro ||
                    widget.skuIdType == SkuIdType.starter)
            ? (widget.skuIdType == SkuIdType.pro ? 5 : 6)
            : widget.skuIdType.index + 1;
        await _payPresenter.getproducts(paymentsParams,
            success: (GoProductsModel? model) {
          if (model != null) {
            if (model.goPayModel != null && model.goPayModel!.isNotEmpty) {
              _priceList = model.goPayModel ?? {};
              payManger.init(widget.skuIdType, model.goPayModel!.keys.toList());
              showProgress();
            } else {
              NavigatorUtils.goBack(context);
            }
          } else {
            NavigatorUtils.goBack(context);
          }
        });

        payManger.productsubject.listen((List<ProductDetails> products) async {
          closeProgress();
          setState(() {});
          if (widget.skuIdType == SkuIdType.pro ||
              widget.skuIdType == SkuIdType.starter) {
            if (payManger.products.isNotEmpty) {
              await _getOrderOn(1);
            } else {
              NavigatorUtils.goBack(context);
            }
          }
        });
        payManger.purchasedSubject
            .listen((PurchaseStatusModel purchaseStatusModel) async {
          if (purchaseStatusModel.isShowProgress ?? false) {
            showProgress();
          } else {
            closeProgress();
          }
          if (purchaseStatusModel.purchaseDetails?.status ==
              PurchaseStatus.error) {
            if (widget.skuIdType == SkuIdType.pro ||
                widget.skuIdType == SkuIdType.starter) {
              NavigatorUtils.goBack(context);
            }
          }
          if (purchaseStatusModel.purchaseDetails?.status ==
              PurchaseStatus.purchased) {
            final PayParams params = PayParams();
            params.orderOn = payModel.orderOn;
            if (Device.isIOS) {
              params.productId =
                  purchaseStatusModel.purchaseDetails?.productID.toString();
              params.receiptdata = purchaseStatusModel
                  .purchaseDetails?.verificationData.localVerificationData;
              await _payPresenter.iosPay(params, paySuccess: () async {});
              await _payPresenter.getUserInfo(success: () {
                NavigatorUtils.goBack(context);
                widget.onPressed!();
              });
            } else {
              final String data = purchaseStatusModel.purchaseDetails
                      ?.verificationData.localVerificationData ??
                  '';
              final Map<dynamic, dynamic> data1 = convert.json.decode(data)
                  as Map<dynamic,
                      dynamic>; //将json字符串转换为map类型。 等同于jsonDecode(jsonStr);
              params.purchaseToken = data1['purchaseToken'].toString();
              if (widget.skuIdType == SkuIdType.pro ||
                  widget.skuIdType == SkuIdType.starter) {
                params.subscriptionId =
                    purchaseStatusModel.purchaseDetails?.productID.toString();
                await _payPresenter.googSubscriptionlePay(params,
                    paySuccess: () {});
              } else {
                params.productId =
                    purchaseStatusModel.purchaseDetails?.productID.toString();
                await _payPresenter.googlePay(params, paySuccess: () {});
              }

              await _payPresenter.getUserInfo(success: () {
                NavigatorUtils.goBack(context);
                widget.onPressed!();
              });
            }
          }

          print(purchaseStatusModel.purchaseDetails?.purchaseID);
          print(purchaseStatusModel.purchaseDetails?.productID);
          print(purchaseStatusModel.purchaseDetails?.verificationData.localVerificationData);
          print(purchaseStatusModel.purchaseDetails?.verificationData.source);
          print(purchaseStatusModel.purchaseDetails?.transactionDate);
          print(purchaseStatusModel.purchaseDetails?.status);
          print(purchaseStatusModel.purchaseDetails?.error);
        });
      },
    );
  }

  @override
  void dispose() {
    payManger.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.skuIdType == SkuIdType.pro ||
            widget.skuIdType == SkuIdType.starter
        ? Gaps.empty
        : BaseDialog(
            title: 'Choose one package',
            rightTitle: 'Confirm',
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp10),
              height: 200.h,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: payManger.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return piecesItem(context, payManger.products[index], index);
                },
              ),
            ),
            onPressed: () async {
              if (payManger.products.isNotEmpty) {
                final ProductDetails productDetails =
                    payManger.products[_seletedIndex];
                await _getOrderOn(
                    int.parse(productDetails.title.substring(0, 3).trim()));
              }
            },
          );
  }

  Widget piecesItem(
      BuildContext context, ProductDetails productDetails, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _seletedIndex = index;
        });
      },
      child: Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp10),
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: Dimens.gap_dp1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(productDetails.title.replaceAll('(FlashInfo)', '')),
            ),
            Gaps.hGap4,
            IconFont(
                name: 0xe63b,
                size: Dimens.font_sp22,
                color: _seletedIndex == index
                    ? Colours.app_main
                    : Colours.text_gray_c),
            SizedBox(
              width: 60.w,
              child: Text(
                '\$ ${_priceList[productDetails.id].toString()}',
                textAlign: TextAlign.center,
                style: TextStyles.textSize14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
