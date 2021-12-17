import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/page/employee/show_unlock_contact.dart';
import 'package:flashinfo/company/page/employee/unlock_contact.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/pay/pay_router.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/base_bottom_sheet.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyPeopleContact extends StatefulWidget {
  const CompanyPeopleContact({Key? key, required this.companyId, this.list})
      : super(key: key);
  final String? companyId;
  final List<PeoplesModel>? list;
  @override
  _CompanyPeopleContactState createState() => _CompanyPeopleContactState();
}

class _CompanyPeopleContactState extends State<CompanyPeopleContact>
    with BasePageMixin<CompanyPeopleContact, PowerPresenter>
    implements
        CompanyDetialIMvpView,
        CompanyEmployeeIMvpView,
        PeopleUnlockIMvpView {
  @override
  CompanyProvider companyProvider = CompanyProvider();
  @override
  BaseListProvider<CompanyModel> companyListProvider =
      BaseListProvider<CompanyModel>();
  @override
  BaseListProvider<PeoplesModel> employeePeopleProvider =
      BaseListProvider<PeoplesModel>();
  @override
  BaseListProvider<PeoplesModel> peopleContactProvider =
      BaseListProvider<PeoplesModel>();
  late CompanyDetailPresenter _companyDetailPresenter;
  late CompanyEmployeePresenter _companyEmployeePresenter;
  late PeopleUnlockPresenter _peopleUnlockPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyDetailPresenter = CompanyDetailPresenter();
    _companyDetailPresenter.companyId = widget.companyId ?? '';
    _companyEmployeePresenter = CompanyEmployeePresenter();
    _peopleUnlockPresenter = PeopleUnlockPresenter();
    powerPresenter.requestPresenter([
      _companyDetailPresenter,
      _companyEmployeePresenter,
      _peopleUnlockPresenter
    ]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        peopleContactProvider.addAll(widget.list ?? []);
        _companyDetailPresenter.peopleContactOnRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<PeoplesModel>>(
      create: (_) => peopleContactProvider,
      child: Consumer<BaseListProvider<PeoplesModel>>(
        builder: (_, provider, __) {
          return BaseBottomSheet(
            height: 600.h,
            children: [
              Text(
                'Contact',
                style: TextStyles.textBold20,
              ),
              Visibility(
                visible: provider.list.isNotEmpty,
                child: GestureDetector(
                  onTap: () => NavigatorUtils.push(context,
                      '${CompanyRouder.companyEmployeePage}?companyId=${widget.companyId}'),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp8),
                    child: Text(
                      'Contact more employee',
                      textAlign: TextAlign.right,
                      style: TextStyles.textBold14
                          .copyWith(color: Colours.app_main),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: DeerListView(
                  key: const Key('Peoples_company'),
                  itemCount: provider.list.length,
                  stateType: provider.stateType,
                  onRefresh: _companyDetailPresenter.peopleContactOnRefresh,
                  loadMore: _companyDetailPresenter.peopleContactLoadMore,
                  hasMore: provider.hasMore,
                  totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                  childLayout: _layot(),
                  itemBuilder: (_, index) {
                    final PeoplesModel? model = provider.list[index];
                    return PeopleContactItem(
                      model: model,
                      onTap: () {
                        if (model?.isUnlock ?? false) {
                          showBottomSheet(model, context);
                        } else {
                          AnalyticEventUtil.analyticsUtil
                              .sendAnalyticsEvent('Contact_Unlock_Click');
                          _showUnlockContactDialog(context, model);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showUnlockContactDialog(BuildContext context, PeoplesModel? model) {
    bool selectbool = false;
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Consumer<UserInfoProvider>(builder: (_, userInfoProvider, __) {
          return UnlockContact(
            name: model?.name,
            companyName: model?.companyModel?.name,
            companyAvatar: model?.companyModel?.logo,
            position: model?.position,
            onPressed: () async {
              final CompanyDetailPresenter companyDetailPresenter =
                  new CompanyDetailPresenter();
              if (userInfoProvider.unlockCount > 0) {
                companyDetailPresenter
                    .sendAnalyticsEvent('Company_Contact_Click');
                AnalyticEventUtil.analyticsUtil
                    .sendAnalyticsEvent('Contact_Unlock_Confirm');
                if (selectbool) {
                  return;
                }
                selectbool = true;
                await _peopleUnlockPresenter.peopleUnlock(model?.id ?? '',
                    success: (email, mobile) {
                  NavigatorUtils.goBack(context);
                  model?.mobile = mobile;
                  model?.email = email;
                  model?.isUnlock = true;
                  setState(() {});
                });
              } else {
                //不是vip
                companyDetailPresenter
                    .sendAnalyticsEvent('Company_Contact_Vip');
                NavigatorUtils.pushResult(context, PayRouter.paymentPage,
                    (value) {
                  print(value);
                }, arguments: SkuIdType.contact);
              }
            },
          );
        });
      },
    );
  }

  //显示底部弹框的功能
  void showBottomSheet(PeoplesModel? model, BuildContext context) {
    //用于在底部打开弹框的效果
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return ShowUnlockContact(
            mobile: model?.mobile ?? '',
            email: model?.email ?? '',
            id: model?.id??'',
          );
        });
  }

  Widget _layot() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'No contact information yet. You can go to the employee list to seak more information',
              style: TextStyles.textBold15
                  .copyWith(color: Colours.text_gray, height: 1.5),
            ),
            Gaps.vGap32,
            GestureDetector(
              onTap: () => NavigatorUtils.push(context,
                  '${CompanyRouder.companyEmployeePage}?companyId=${widget.companyId}'),
              child: Text(
                'Contact more employee',
                textAlign: TextAlign.center,
                style: TextStyles.textBold16.copyWith(color: Colours.app_main),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PeopleContactItem extends StatelessWidget {
  const PeopleContactItem({Key? key, this.model, this.onTap}) : super(key: key);
  final PeoplesModel? model;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimens.gap_v_dp5, top: Dimens.gap_v_dp5),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(width: 1, color: Colours.border_grey)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoadBorderImage(model?.avatar ?? '',
                          width: 50.w,
                          height: 50.h,
                          holderImg: 'personnel/personnel'),
                      Gaps.vGap5,
                      Text(
                        model?.position ?? '-',
                        style: TextStyles.textSize13,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Gaps.hGap10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model?.name ?? '-',
                        style: TextStyles.textBold15,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gaps.vGap15,
                      Row(
                        children: [
                          const IconFont(
                            name: 0xe625,
                            color: Colours.text,
                            size: 15,
                          ),
                          Gaps.hGap10,
                          Expanded(
                            child: Text(
                              model?.mobile ?? '-',
                              style: TextStyles.textGray12
                                  .copyWith(color: Colours.app_main),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap15,
                      Row(
                        children: [
                          const IconFont(
                            name: 0xe62a,
                            color: Colours.text,
                            size: 15,
                          ),
                          Gaps.hGap10,
                          Expanded(
                            child: Text(
                              model?.email ?? '-',
                              style: TextStyles.textGray12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 60.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: (model?.isUnlock ?? false)
                            ? Colours.text_gray_c
                            : const Color(0xffD6E2FB),
                      ),
                      borderRadius: BorderRadius.circular(3.0.w),
                    ),
                    child: Column(
                      children: [
                        if (model?.isUnlock ?? false)
                          IconFont(
                            name: 0xe652,
                            color: Colours.text_gray,
                            size: Dimens.font_sp18,
                          )
                        else
                          IconFont(
                            name: 0xe650,
                            color: Colours.app_main,
                            size: Dimens.font_sp18,
                          ),
                        Text(
                          (model?.isUnlock ?? false) ? 'view' : 'Unlock',
                          style: TextStyles.textSize13.copyWith(
                              color: (model?.isUnlock ?? false)
                                  ? Colours.text_gray_c
                                  : Colours.app_main),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
