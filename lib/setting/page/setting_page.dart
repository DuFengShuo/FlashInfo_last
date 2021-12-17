import 'dart:io';

import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/profile/presenter/personal_presenter.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/profile/widget/input_text_page.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/setting/widgets/log_out_dialog.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/bottom_sheet_widget.dart';
import 'package:flashinfo/widgets/click_item.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with BasePageMixin<SettingPage, PowerPresenter> {
  final ImagePicker _picker = ImagePicker();
  ImageProvider? _imageProvider;
  PickedFile? pickedFile;
  String? url;
  Future<void> _getImage(int index) async {
    try {
      pickedFile =
          // ignore: deprecated_member_use
          await _picker.getImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile != null) {
        if (Device.isWeb) {
          _imageProvider = NetworkImage(pickedFile!.path);
        } else {
          _imageProvider = FileImage(File(pickedFile!.path));
        }
      } else {
        _imageProvider = null;
      }
      await _personalPresenter.renewAvatar(File(pickedFile?.path ?? ''));
    } catch (e) {
      if (e is MissingPluginException) {
        Toast.show('It is not supported on the current platform！');
      } else {
        Toast.show('Unable to open album without permission！');
      }
    }
  }

  late PersonalPresenter _personalPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _personalPresenter = PersonalPresenter();
    powerPresenter.requestPresenter([_personalPresenter]);
    return powerPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(
        centerTitle: 'Accounts',
      ),
      body: Column(
        children: [
          Gaps.line,
          Container(
            color: Colours.material_bg,
            width: double.infinity,
            height: 54.0.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Text('Welcome', style: TextStyles.textGray16),
          ),
          InkWell(
            onTap: () {
              showBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colours.material_bg,
                border: Border(
                  bottom: Divider.createBorderSide(context, width: 0.8.w),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Portrait',
                    style:
                        TextStyles.text.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const Expanded(child: Gaps.empty),
                  Consumer<UserInfoProvider>(builder: (_, provider, __) {
                    return Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        // 图片圆角展示
                        borderRadius: BorderRadius.all(Radius.circular(14.0.w)),
                        image: DecorationImage(
                          image: _imageProvider ??
                              ImageUtils.getImageProvider(
                                  provider.userInfoModel?.avatar ?? '',
                                  holderImg: 'me/avatar'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                  Gaps.hGap8,
                  Images.arrowRight
                ],
              ),
            ),
          ),
          // Consumer<UserInfoProvider>(builder: (_, provider, __) {
          //   return ClickItem(
          //       title: 'Username',
          //       content: provider.userInfoModel?.name ?? '',
          //       onTap: () {
          //         _goInputTextPage(
          //           context,
          //           false,
          //           'Username',
          //           'Please enter nickname',
          //           provider.userInfoModel?.name ?? '',
          //           (value) async {
          //             final Map<String, String> params = <String, String>{};
          //             params['name'] = value.toString();
          //             await _personalPresenter.updateUser(params);
          //           },
          //         );
          //       });
          // }),
          Consumer<UserInfoProvider>(builder: (_, provider, __) {
            return ClickItem(
              title: 'Cellphone',
              content: provider.userInfoModel?.mobile ?? '',
            );
          }),
          Gaps.lineV,
          InkWell(
            onTap: _showExitDialog,
            child: Container(
              color: Colours.material_bg,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16.0.w),
              width: double.infinity,
              height: 50.0.h,
              child: Text('Log Out',
                  style: TextStyles.text.copyWith(
                    color: Colours.red,
                  )),
            ),
          ),
          // if (Device.isMobile)
          //   ClickItem(
          //     title: '检查更新',
          //     onTap: _showUpdateDialog,
          //   ),
        ],
      ),
    );
  }

  // void _showUpdateDialog() {
  //   showDialog<void>(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (_) => const UpdateDialog());
  // }

  void _showExitDialog() {
    showDialog<void>(context: context, builder: (_) => const LogOutDialog());
  }

  void _goInputTextPage(BuildContext context, bool isNext, String titleText,
      String hintText, String content, Function(Object?) function,
      {TextInputType? keyboardType, String? otherText, String? title}) {
    NavigatorUtils.pushResult(context, ProfileRouter.inputTextPage, function,
        arguments: InputTextPageArgumentsData(
          isNext: isNext,
          title: title,
          titleText: titleText,
          hintText: hintText,
          content: content,
          otherText: otherText,
          keyboardType: keyboardType,
        ));
  }

  //显示底部弹框的功能
  void showBottomSheet() {
    //用于在底部打开弹框的效果
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return BottomSheetWidget(
              titleList: const [
                'Taking pictures',
                'Select from your phone photo album'
              ],
              onIndexTap: (index) async {
                await _getImage(index);
              });
        });
  }
}
