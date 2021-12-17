import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/iview/personal_ivew.dart';
import 'package:flashinfo/personal/model/educations_bean.dart';
import 'package:flashinfo/personal/presenter/personal_details_other_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/base_bottom_sheet.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalDetailsDducation extends StatefulWidget {
  const PersonalDetailsDducation({Key? key, this.personnelId})
      : super(key: key);
  final String? personnelId;
  @override
  _PersonalDetailsDducationState createState() =>
      _PersonalDetailsDducationState();
}

class _PersonalDetailsDducationState extends State<PersonalDetailsDducation>
    with BasePageMixin<PersonalDetailsDducation, PowerPresenter>
    implements PersonalDducationIMvpView {
  @override
  BaseListProvider<EducationsModel> personalDducationProvider =
      BaseListProvider<EducationsModel>();

  late PersonalDducationPresenter _personalDducationPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _personalDducationPresenter = PersonalDducationPresenter();
    _personalDducationPresenter.personnelId = widget.personnelId ?? '';
    powerPresenter.requestPresenter([_personalDducationPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        _personalDducationPresenter.onRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<EducationsModel>>(
      create: (_) => personalDducationProvider,
      child: Consumer<BaseListProvider<EducationsModel>>(
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
                  onRefresh: _personalDducationPresenter.onRefresh,
                  loadMore: _personalDducationPresenter.loadMore,
                  hasMore: provider.hasMore,
                  totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                  itemBuilder: (_, index) {
                    return PersonDetailsEducationItem(
                        model: provider.list[index]);
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

class PersonDetailsEducationItem extends StatelessWidget {
  const PersonDetailsEducationItem({Key? key, this.model}) : super(key: key);
  final EducationsModel? model;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.only(top: Dimens.gap_v_dp10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadBorderImage(model?.eduLogo ?? '',
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
                  model?.eduName ?? '',
                  style: TextStyles.textBold15,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  model?.subject ?? '',
                  style: TextStyles.textGray13,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Visibility(
                  visible: true,
                  child:Text(
                  '${model?.startYear??'' }-${model?.endYear??''}',
                  style: TextStyles.textGray13,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ), )

              ],
            ),
          ))
        ],
      ),
    );
  }
}
