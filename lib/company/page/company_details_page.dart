import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/models/company_subsidiary_model.dart';
import 'package:flashinfo/company/page/scrollable_list_page.dart';
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/company/widget/bottomSheet/company_people_contact.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CompanyDetailsPage extends StatefulWidget {
  const CompanyDetailsPage({Key? key, required this.companyId, this.model, this.isToIndex})
      : super(key: key);
  final String companyId;
  final CompanyModel? model;
  final String? isToIndex;
  @override
  _CompanyDetailsPageState createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends State<CompanyDetailsPage>
    with BasePageMixin<CompanyDetailsPage, PowerPresenter>
    implements CompanyDetialIMvpView {
  final PublishSubject<CompanySubsidiaryModel> _subsidiarySubject =
      PublishSubject<CompanySubsidiaryModel>();
  int showSearch = 0;
  @override
  CompanyProvider companyProvider = CompanyProvider();
  @override
  BaseListProvider<CompanyModel> companyListProvider =
      BaseListProvider<CompanyModel>();
  @override
  BaseListProvider<PeoplesModel> peopleContactProvider =
      BaseListProvider<PeoplesModel>();
  late CompanyDetailPresenter _companyDetailPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyDetailPresenter = CompanyDetailPresenter();
    powerPresenter.requestPresenter([_companyDetailPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    companyProvider.setStateType(StateType.detailLayout);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        await _companyDetailPresenter.getCompanyDetail(widget.companyId);
        // await _companyDetailPresenter.getCompanySubsidiary(widget.companyId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CompanyProvider>(
        create: (_) => companyProvider,
        child: Consumer<CompanyProvider>(builder: (_, provider, __) {
          final CompanyDetailsBean? model = provider.companyDetailsBean;
          if (provider.companySubsidiaryModel != null) {
            _subsidiarySubject.add(provider.companySubsidiaryModel!);
          }
          return Scaffold(
              body: model == null
                  ? StateLayout(
                      type: provider.stateType,
                    )
                  : ScrollablePositionedListPage(
                      companyModel: widget.model,
                      companyDetailPresenter: _companyDetailPresenter,
                      model: model,
                      subsidiarySubject: _subsidiarySubject,
                      isToOfficer: (widget.isToIndex!=null && widget.isToIndex!.isNotEmpty)?true:false,
              ));
        }));
  }

  //显示底部弹框的功能
  void showBottomSheet(
      BuildContext context, String? companyId, List<PeoplesModel>? list) {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
      showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => LoginToastDialog(onPressed: () {
                Navigator.pop(context);
                NavigatorUtils.push(context, LoginRouter.smsLoginPage);
              }));
      return;
    }
    //用于在底部打开弹框的效果
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return CompanyPeopleContact(list: list ?? [], companyId: companyId);
        });
  }
}

class CompanyTabIndexModel {
  int? index;
  bool? isUpdate;

  CompanyTabIndexModel({
    this.index = 0,
    this.isUpdate = false,
  });
}
