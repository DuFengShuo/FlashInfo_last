import 'package:flashinfo/login/widgets/my_text_field.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/profile/presenter/personal_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/search/iview/search_iview.dart';
import 'package:flashinfo/search/model/autocomplete_bean.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/search/widgets/autocomplete_menu_widget.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../guide_router.dart';

class GuideEmployerPage extends StatefulWidget {
  const GuideEmployerPage({Key? key, required this.personalParams})
      : super(key: key);
  final PersonalParams personalParams;
  @override
  _GuideEmployerPageState createState() => _GuideEmployerPageState();
}

class _GuideEmployerPageState extends State<GuideEmployerPage>
    with
        ChangeNotifierMixin<GuideEmployerPage>,
        BasePageMixin<GuideEmployerPage, PowerPresenter>
    implements SearchCacheIMvpView {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  bool _clickable = false;
  bool valuea = false;
  late GZXDropdownMenuController autocompleteMenuController =
      GZXDropdownMenuController(); //自动补全线上列表
  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _nodeText1: null,
    };
  }

  @override
  String searchValue = ''; //搜索框文本

  @override
  BaseListProvider<AutocompleteModel> autoListProvider =
      BaseListProvider<AutocompleteModel>();
  @override
  void dispose() {
    super.dispose();
    autocompleteMenuController.dispose();
  }

  late SearchCachePresenter _searchCachePresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _searchCachePresenter = SearchCachePresenter();
    powerPresenter.requestPresenter([_searchCachePresenter]);
    return powerPresenter;
  }

  void _verify() {
    final String name = _nameController.text.trim();
    bool clickable = true;
    if (name.isEmpty) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _next() {
    widget.personalParams.companyName = _nameController.text.trim();
    widget.personalParams.workStatus = valuea ? 1 : 0;
    NavigatorUtils.push(context, GuideRouter.guideNamePage,
        arguments: widget.personalParams);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<AutocompleteModel>>(
            create: (_) => autoListProvider),
      ],
      child: WillPopScope(
        onWillPop: () {
          /// 拦截返回，关闭键盘，否则会造成上一页面短暂的组件溢出
          FocusManager.instance.primaryFocus?.unfocus();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: MyAppBar(
            isBack: false,
            actionName: 'Skip',
            onPressed: _next,
            textColor: Colours.app_main,
          ),
          body: MyScrollView(
            keyboardConfig: Utils.getKeyboardActionsConfig(
                context, <FocusNode>[_nodeText1]),
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
            bottomButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              child: MyButton(
                key: const Key('Next'),
                onPressed: _clickable ? _next : null,
                text: 'Next',
              ),
            ),
            children: [
              Gaps.line,
              Gaps.vGap50,
              Text(
                'Most Recent Employer',
                style: TextStyles.textBold28.copyWith(color: Colours.app_main),
              ),
              Gaps.vGap10,
              Text(
                  'Tell us a little about yourself so we can customize your experience',
                  style: TextStyles.textBold14),
              Gaps.vGap50,
              MyTextField(
                focusNode: _nodeText1,
                controller: _nameController,
                maxLength: 50,
                keyboardType: TextInputType.text,
                hintText: 'Please enter your position',
                onChanged: (value) async {
                  if (value.trim().length < 3) {
                    autoListProvider.clear();
                    if (autocompleteMenuController.isShow) {
                      autocompleteMenuController.hide();
                    }
                    return;
                  }
                  setState(() {
                    searchValue = value;
                  });
                  await _searchCachePresenter.searchAutocomplete(
                      loginSuccess: (bool isData) {
                    if (isData) {
                      if (!autocompleteMenuController.isShow) {
                        autocompleteMenuController.show(0);
                      }
                    } else {
                      if (autocompleteMenuController.isShow) {
                        autocompleteMenuController.hide();
                      }
                    }
                  });
                },
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 400.h,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.vGap50,
                        Text('Are you still work in this company?',
                            style: TextStyles.textBold14),
                        Gaps.vGap10,
                        CupertinoSwitch(
                          value: valuea,
                          activeColor: Colours.app_main,
                          onChanged: (value) {
                            setState(() {
                              valuea = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  //自动补全下拉框
                  Consumer<BaseListProvider<AutocompleteModel>>(
                      builder: (_, provider, __) {
                    return AutocompleteMenuWidget(
                      autocompleteList: provider.list,
                      dropdownMenuController: autocompleteMenuController,
                      onTap: (String value) {
                        autoListProvider.clear();
                        if (autocompleteMenuController.isShow) {
                          autocompleteMenuController.hide();
                        }
                        _nameController.text = value;
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
