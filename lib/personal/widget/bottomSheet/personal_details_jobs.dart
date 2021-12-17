import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/iview/personal_ivew.dart';
import 'package:flashinfo/personal/model/works_bean.dart';
import 'package:flashinfo/personal/presenter/personal_details_other_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/base_bottom_sheet.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalDetailsJobs extends StatefulWidget {
  const PersonalDetailsJobs({Key? key, this.personnelId}) : super(key: key);
  final String? personnelId;
  @override
  _PersonalDetailsJobsState createState() => _PersonalDetailsJobsState();
}

class _PersonalDetailsJobsState extends State<PersonalDetailsJobs>
    with BasePageMixin<PersonalDetailsJobs, PowerPresenter>
    implements PersonalJobsIMvpView {
  @override
  BaseListProvider<WorksModel> personalJobsProvider =
      BaseListProvider<WorksModel>();

  late PersonalJobsPresenter _personalJobsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _personalJobsPresenter = PersonalJobsPresenter();
    _personalJobsPresenter.personnelId = widget.personnelId ?? '';
    powerPresenter.requestPresenter([_personalJobsPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        _personalJobsPresenter.onRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<WorksModel>>(
      create: (_) => personalJobsProvider,
      child: Consumer<BaseListProvider<WorksModel>>(
        builder: (_, provider, __) {
          return BaseBottomSheet(
            height: 600.h,
            children: [
              Text(
                'Working Experience',
                style: TextStyles.textBold20.copyWith(color: Colours.app_main),
              ),
              Gaps.vGap10,
              Expanded(
                child: DeerListView(
                  key: const Key('Working_company'),
                  itemCount: provider.list.length,
                  stateType: provider.stateType,
                  onRefresh: _personalJobsPresenter.onRefresh,
                  loadMore: _personalJobsPresenter.loadMore,
                  hasMore: provider.hasMore,
                  totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                  itemBuilder: (_, index) {
                    return PersonDetailsJobItem(model: provider.list[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PersonDetailsJobItem extends StatelessWidget {
  const PersonDetailsJobItem({Key? key, this.model}) : super(key: key);
  final WorksModel? model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorUtils.push(context,
          '${CompanyRouder.companyDetailsPage}?companyId=${model?.companyId}'),
      child: Container(
        height: 90.h,
        padding: EdgeInsets.only(top: Dimens.gap_v_dp10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadBorderImage(model?.companyLogo ?? '',
                width: 50.w, height: 50.h, holderImg: 'product/product'),
            Gaps.hGap10,
            Expanded(
                child: Container(
              padding: EdgeInsets.only(bottom: Dimens.gap_v_dp10),
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      Divider.createBorderSide(context, width: Dimens.gap_dp1),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model?.companyName ?? '-',
                    style: TextStyles.textBold15,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model?.position ?? '-',
                    style: TextStyles.textGray13,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'From September ${model?.entryTime ?? ''}',
                            style: TextStyles.textGray13,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gaps.hGap10,
                        Text(
                          model?.leaveTime ?? '',
                          style: TextStyles.textGray13,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
