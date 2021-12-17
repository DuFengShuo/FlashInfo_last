import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/base_bottom_sheet.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyDetailsBranches extends StatefulWidget {
  const CompanyDetailsBranches({Key? key, required this.companyId})
      : super(key: key);
  final String? companyId;

  @override
  _CompanyDetailsBranchesState createState() => _CompanyDetailsBranchesState();
}

class _CompanyDetailsBranchesState extends State<CompanyDetailsBranches>
    with BasePageMixin<CompanyDetailsBranches, PowerPresenter>
    implements CompanyDetialIMvpView {
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
    _companyDetailPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyDetailPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        _companyDetailPresenter.companyOnRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<CompanyModel>>(
      create: (_) => companyListProvider,
      child: Consumer<BaseListProvider<CompanyModel>>(
        builder: (_, provider, __) {
          return BaseBottomSheet(
            height: 600.h,
            children: [
              Row(
                children: [
                  Text(
                    'Branches',
                    style: TextStyles.textBold18.copyWith(color: Colours.text),
                  ),
                  Gaps.hGap5,
                  Text(
                    '${provider.metaModel?.pagination?.total ?? 0}',
                    style:
                        TextStyles.textBold18.copyWith(color: Colours.app_main),
                  ),
                ],
              ),
              Gaps.vGap10,
              Expanded(
                child: DeerListView(
                  key: const Key('Branche_company'),
                  itemCount: provider.list.length,
                  stateType: provider.stateType,
                  onRefresh: _companyDetailPresenter.companyOnRefresh,
                  loadMore: _companyDetailPresenter.companyLoadMore,
                  hasMore: provider.hasMore,
                  totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                  itemBuilder: (_, index) {
                    return BranchesItemWidget(model: provider.list[index]);
                  },
                ),
              ),
              Gaps.vGap10,
              MyButton(
                onPressed: () => NavigatorUtils.goBack(context),
                text: 'OK',
                minHeight: 44.h,
                backgroundColor: Colours.app_main,
                textColor: Colours.material_bg,
                radius: 40.r,
              )
            ],
          );
        },
      ),
    );
  }
}

class BranchesItemWidget extends StatelessWidget {
  const BranchesItemWidget({Key? key, this.model}) : super(key: key);
  final CompanyModel? model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        NavigatorUtils.push(context,
            '${CompanyRouder.companyDetailsPage}?companyId=${model?.id}');
      } ,
      child: Container(
        margin: EdgeInsets.only(bottom: Dimens.gap_v_dp5, top: Dimens.gap_v_dp5),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colours.border_grey,
                  width: 1,
                  // style: BorderStyle.solid
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoadBorderImage(model?.logo ?? '',
                            width: 45.w,
                            height: 45.w,
                            holderImg: 'product/product'),
                        Gaps.hGap10,
                        Expanded(
                          child: Text(
                            model?.name ?? '-',
                            style: TextStyles.textBold14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Gaps.vGap4,
                    Row(
                      children: [
                        Text(
                          'Location：',
                          style: TextStyles.textGray12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text(
                            '${model?.location ?? '-'}',
                            style: TextStyles.textSize12
                                .copyWith(color: Colours.text),
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap4,
                    Row(
                      children: [
                        Text(
                          'Employee：',
                          style: TextStyles.textGray12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text(
                            '${model?.peopleNumber ?? '-'}',
                            style: TextStyles.textSize12
                                .copyWith(color: Colours.text),
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap4,
                    Row(
                      children: [
                        Text(
                          'Founded Year：',
                          style: TextStyles.textGray12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text(
                            '${model?.foundDate ?? '-'}',
                            style: TextStyles.textSize12
                                .copyWith(color: Colours.text),
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }
}
