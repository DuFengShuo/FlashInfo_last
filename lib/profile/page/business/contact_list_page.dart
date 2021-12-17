import 'package:flashinfo/company/page/employee/show_unlock_contact.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/profile/iview/contact_iview.dart';
import 'package:flashinfo/profile/model/people_unlock_bean.dart';
import 'package:flashinfo/profile/presenter/contact_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key, this.companyId}) : super(key: key);
  final String? companyId;
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage>
    with BasePageMixin<ContactListPage, PowerPresenter>
    implements ContactIMvpView {
  @override
  BaseListProvider<PeopleUnlockModel> peopleUnlocProvider =
      BaseListProvider<PeopleUnlockModel>();
  late ContactPresenter _contactPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _contactPresenter = ContactPresenter();
    powerPresenter.requestPresenter([_contactPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<PeopleUnlockModel>>(
            create: (_) => peopleUnlocProvider),
      ],
      child: Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: const MyAppBar(
          centerTitle: 'Contact',
        ),
        body: Consumer<BaseListProvider<PeopleUnlockModel>>(
          builder: (_, provider, __) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The fastest way to make more sales',
                    style: TextStyles.textBold13,
                  ),
                  Gaps.vGap10,
                  Expanded(
                      child: DeerListView(
                    key: const Key('employee_list'),
                    itemCount: provider.list.length,
                    stateType: provider.stateType,
                    onRefresh: _contactPresenter.onRefresh,
                    loadMore: _contactPresenter.loadMore,
                    hasMore: provider.hasMore,
                    totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                    itemBuilder: (_, index) {
                      final PeopleUnlockModel? model = provider.list[index];
                      return ContactListItem(
                        model: model,
                        // onTapItem: () => NavigatorUtils.pushResult(context,
                        //     '${PersonalRouter.personalDetailsPage}?personalId=${model?.id}',
                        //     (value) {
                        //   print(value);
                        // }, arguments: model),
                        onTap: () => showBottomSheet(model, context),
                      );
                    },
                  ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  //显示底部弹框的功能
  void showBottomSheet(PeopleUnlockModel? model, BuildContext context) {
    //用于在底部打开弹框的效果
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return ShowUnlockContact(
            mobile: model?.mobile ?? '',
            email: model?.email ?? '',
            avatar: model?.avatar??'',
            name: model?.contactName??'',
            position: model?.province,
            id: model?.id??'',
          );
        });
  }
}

class ContactListItem extends StatelessWidget {
  const ContactListItem({Key? key, this.model, this.onTap, this.onTapItem})
      : super(key: key);
  final PeopleUnlockModel? model;
  final void Function()? onTap;
  final void Function()? onTapItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Padding(
        padding: EdgeInsets.only(bottom: Dimens.gap_v_dp10),
        child: MyCard(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp12, vertical: Dimens.gap_v_dp12),
          child: Row(
            children: [
              LoadBorderImage(model?.avatar ?? '',
                  width: 58.w, height: 58.h, holderImg: 'personnel/personnel'),
              Gaps.hGap10,
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 58.0.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model!.contactName!.isEmpty?'-': model?.contactName ??'',
                        style: TextStyles.textBold15,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        model!.province!.isEmpty?'-': model?.province ??'',
                        style: TextStyles.textGray10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: model!.mobile!.isNotEmpty,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.gap_dp5,
                                  vertical: Dimens.gap_v_dp2),
                              decoration: BoxDecoration(
                                color: const Color(0xffD6E2FB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0.h)),
                              ),
                              child: Text(
                                'Contact number(1)',
                                style: TextStyles.textSize10
                                    .copyWith(color: Colours.app_main),
                              ),
                            ),
                          ),
                          Gaps.hGap10,
                          Visibility(
                            visible: model!.email!.isNotEmpty,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.gap_dp5,
                                  vertical: Dimens.gap_v_dp2),
                              decoration: BoxDecoration(
                                color: const Color(0xffD6E2FB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0.h)),
                              ),
                              child: Text(
                                'Email(1)',
                                style: TextStyles.textSize10
                                    .copyWith(color: Colours.app_main),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
                      color: Colours.text_gray_c,
                    ),
                    borderRadius: BorderRadius.circular(3.0.w),
                  ),
                  child: Column(children: [
                    IconFont(
                      name: 0xe652,
                      color: Colours.text_gray,
                      size: Dimens.font_sp18,
                    ),
                    Text('view',
                        style: TextStyles.textSize13.copyWith(
                          color: Colours.text_gray_c,
                        ))
                  ]),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
