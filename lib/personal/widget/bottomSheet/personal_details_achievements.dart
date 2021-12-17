import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/iview/personal_ivew.dart';
import 'package:flashinfo/personal/model/honors_bean.dart';
import 'package:flashinfo/personal/presenter/personal_details_other_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/base_bottom_sheet.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalDetailsAchievements extends StatefulWidget {
  const PersonalDetailsAchievements({Key? key, this.personnelId})
      : super(key: key);
  final String? personnelId;
  @override
  _PersonalDetailsAchievementsState createState() =>
      _PersonalDetailsAchievementsState();
}

class _PersonalDetailsAchievementsState
    extends State<PersonalDetailsAchievements>
    with BasePageMixin<PersonalDetailsAchievements, PowerPresenter>
    implements PersonalHonorsIMvpView {
  @override
  BaseListProvider<HonorsModel> personalHonorsProvider =
      BaseListProvider<HonorsModel>();

  late PersonalHonorsPresenter _personalHonorsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _personalHonorsPresenter = PersonalHonorsPresenter();
    _personalHonorsPresenter.personnelId = widget.personnelId ?? '';
    powerPresenter.requestPresenter([_personalHonorsPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        _personalHonorsPresenter.onRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<HonorsModel>>(
      create: (_) => personalHonorsProvider,
      child: Consumer<BaseListProvider<HonorsModel>>(
        builder: (_, provider, __) {
          return BaseBottomSheet(
            height: 600.h,
            children: [
              Text(
                'Personal Achievements',
                style: TextStyles.textBold20.copyWith(color: Colours.app_main),
              ),
              Gaps.vGap10,
              Expanded(
                child: DeerListView(
                  key: const Key('Achievements_company'),
                  itemCount: provider.list.length,
                  stateType: provider.stateType,
                  onRefresh: _personalHonorsPresenter.onRefresh,
                  loadMore: _personalHonorsPresenter.loadMore,
                  hasMore: provider.hasMore,
                  totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                  itemBuilder: (_, index) {
                    return PersonDetailsAchievementsItem(
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

class PersonDetailsAchievementsItem extends StatelessWidget {
  const PersonDetailsAchievementsItem({Key? key, this.model}) : super(key: key);
  final HonorsModel? model;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: Dimens.gap_dp1),
        ),
      ),
      height: 70.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadBorderImage('',
              width: 50.w, height: 50.h, holderImg: 'product/product'),
          Gaps.hGap10,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model?.honorName ?? '',
                  style:
                      TextStyles.textBold14.copyWith(color: Colours.app_main),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gaps.vGap5,
                Text(
                  '${model?.organizationName}(${model?.year})',
                  style: TextStyles.textGray13,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
