import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/search/iview/search_iview.dart';
import 'package:flashinfo/search/model/autocomplete_bean.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/search/widgets/autocomplete_menu_widget.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonEmployerPage extends StatefulWidget {
  const PersonEmployerPage({Key? key, required this.companyName})
      : super(key: key);
  final String? companyName;
  @override
  _PersonEmployerPageState createState() => _PersonEmployerPageState();
}

class _PersonEmployerPageState extends State<PersonEmployerPage>
    with BasePageMixin<PersonEmployerPage, PowerPresenter>
    implements SearchCacheIMvpView {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  late GZXDropdownMenuController autocompleteMenuController =
      GZXDropdownMenuController(); //自动补全线上列表

  @override
  String searchValue = ''; //搜索框文本

  @override
  BaseListProvider<AutocompleteModel> autoListProvider =
      BaseListProvider<AutocompleteModel>();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.companyName ?? '';
  }

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<AutocompleteModel>>(
            create: (_) => autoListProvider),
      ],
      child: Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: MyAppBar(
          actionName: 'Save',
          textColor: Colours.app_main,
          onPressed: () {
            if (_nameController.text.trim().isEmpty) {
              Toast.show('Most recent employer');
              return;
            }
            NavigatorUtils.goBackWithParams(context, _nameController.text);
          },
        ),
        body: MyScrollView(
          keyboardConfig:
              Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1]),
          children: [
            Gaps.vGap15,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              child: Text(
                'Job Title',
                style: TextStyles.textBold15,
              ),
            ),
            Gaps.vGap15,
            TextField(
              focusNode: _nodeText1,
              controller: _nameController,
              maxLength: 50,
              maxLines: 1,
              autofocus: true,
              keyboardType: TextInputType.text,
              style: TextStyles.textSize15,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                fillColor: Colours.material_bg,
                filled: true,
                hintText: 'Most recent employer',
                border: InputBorder.none,
                counterText: '',
              ),
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
                  height: 600.h,
                  width: double.infinity,
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
    );
  }
}
