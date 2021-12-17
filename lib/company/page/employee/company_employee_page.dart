import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/page/employee/show_unlock_contact.dart';
import 'package:flashinfo/company/page/employee/unlock_contact.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/pay/pay_router.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyEmployeePage extends StatefulWidget {
  const CompanyEmployeePage({Key? key, this.companyId, this.contactLimit})
      : super(key: key);
  final String? companyId;
  final int? contactLimit;
  @override
  _CompanyEmployeePageState createState() => _CompanyEmployeePageState();
}

class _CompanyEmployeePageState extends State<CompanyEmployeePage>
    with BasePageMixin<CompanyEmployeePage, PowerPresenter>
    implements CompanyEmployeeIMvpView, PeopleUnlockIMvpView {
  @override
  BaseListProvider<PeoplesModel> employeePeopleProvider =
      BaseListProvider<PeoplesModel>();

  late CompanyEmployeePresenter _companyEmployeePresenter;
  late PeopleUnlockPresenter _peopleUnlockPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyEmployeePresenter = CompanyEmployeePresenter();
    _peopleUnlockPresenter = PeopleUnlockPresenter();
    _companyEmployeePresenter.companyId = widget.companyId ?? '';
    _companyEmployeePresenter.contactLimit = widget.contactLimit ?? 0;
    powerPresenter
        .requestPresenter([_companyEmployeePresenter, _peopleUnlockPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _companyEmployeePresenter.onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<PeoplesModel>>(
            create: (_) => employeePeopleProvider),
      ],
      child: Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: MyAppBar(
          centerTitle: '${widget.contactLimit == 1 ? 'Contact' : 'Employees'} ',
        ),
        body: Consumer2<BaseListProvider<PeoplesModel>, UserInfoProvider>(
          builder: (_, provider, userInfoProvider, __) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp10),
              child: DeerListView(
                key: const Key('employee_list'),
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _companyEmployeePresenter.onRefresh,
                loadMore: _companyEmployeePresenter.loadMore,
                hasMore: provider.hasMore,
                totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                pageSize: 30,
                fuzzyImg: 'personnel/personnel_fuzzy',
                isLogin: userInfoProvider.userInfoModel == null &&
                    (provider.metaModel?.pagination?.total ?? 0) > 6,
                loginName: 'View all employee',
                vipName: 'You can view it after you upgrade your membership',
                itemBuilder: (_, index) {
                  final PeoplesModel? model = provider.list[index];
                  return CompanyEmployeeItem(
                    model: model,
                    onTapItem: () {
                      if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ??
                          false)) {
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
                      NavigatorUtils.pushResult(context,
                          '${PersonalRouter.personalDetailsPage}?personalId=${model?.id}',
                          (value) {
                        print(value);
                      }, arguments: model);
                    },
                    onTap: () {
                      if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ??
                          false)) {
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
                      if (model?.isUnlock ?? false) {
                        showBottomSheet(model, context);
                      } else {
                        _showUnlockContactDialog(context, model);
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
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
            avatar: model?.avatar,
            onPressed: () async {
              if (userInfoProvider.unlockCount > 0) {
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
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return ShowUnlockContact(
            mobile: model?.mobile ?? '',
            email: model?.email ?? '',
            position: model?.position ?? '',
            name: model?.name ?? '',
            avatar: model?.avatar ?? '',
            id: model?.id??'',
          );
        });
  }
}

class CompanyEmployeeItem extends StatelessWidget {
  const CompanyEmployeeItem({Key? key, this.model, this.onTap, this.onTapItem})
      : super(key: key);
  final PeoplesModel? model;
  final void Function()? onTap;
  final void Function()? onTapItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Padding(
        padding: EdgeInsets.only(bottom: Dimens.gap_v_dp10),
        child: Container(
            decoration: BoxDecoration(
                color: Colours.material_bg,
                border: Border.all(
                  color: Colours.border_grey,
                  width: 1,
                  // style: BorderStyle.solid
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp12, vertical: Dimens.gap_v_dp12),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colours.border_grey,
                        borderRadius:
                            BorderRadius.all(Radius.circular(24.0.r))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 21.0.r,
                        backgroundColor: Colours.text_gray_c,
                        backgroundImage: ImageUtils.getImageProvider(
                          model?.avatar ?? '',
                          holderImg: 'personnel/personnel',
                        ),
                      ),
                    ),
                  ),
                  // LoadBorderImage(model?.avatar ?? '',
                  //     width: 58.w, height: 58.h, holderImg: 'personnel/personnel'),
                  Gaps.hGap10,
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model?.name ?? '',
                            style: TextStyles.textBold14.copyWith(
                                color: Colours.app_main,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            model?.position ?? '',
                            style: TextStyles.textGray10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      IconFont(
                        size: 16,
                        name: 0xe629,
                        color: model!.mobile!.isNotEmpty
                            ? Colours.app_main
                            : Colours.text_gray_c,
                      ),
                      Gaps.hGap10,
                      IconFont(
                        size: 16.sp,
                        name: 0xe62a,
                        color: model!.email!.isNotEmpty
                            ? Colours.app_main
                            : Colours.text_gray_c,
                      ),
                    ],
                  ),
                  Gaps.hGap16,
                  Visibility(
                    visible:
                        model!.email!.isNotEmpty || model!.mobile!.isNotEmpty,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (model?.isUnlock ?? false)
                              ? Colours.app_main
                              : Colours.bg_color,
                          border: Border.all(
                            width: 1,
                            color: (model?.isUnlock ?? false)
                                ? Colours.text_gray_c
                                : const Color(0xffD6E2FB),
                          ),
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (model?.isUnlock ?? false)
                              IconFont(
                                isNewIcon: true,
                                name: 0xe665,
                                color: Colours.material_bg,
                                size: Dimens.font_sp16,
                              )
                            else
                              IconFont(
                                isNewIcon: true,
                                name: 0xe666,
                                color: Colours.app_main,
                                size: Dimens.font_sp16,
                              ),
                            Text(
                              (model?.isUnlock ?? false) ? 'view' : 'Unlock',
                              style: TextStyles.textSize10.copyWith(
                                  color: (model?.isUnlock ?? false)
                                      ? Colours.material_bg
                                      : Colours.app_main),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
