import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/theme_utils.dart';
import 'package:flashinfo/widgets/my_button.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key? key,
      this.backgroundColor,
      this.title = '',
      this.centerTitle = '',
      this.actionName = '',
      this.actionIconName,
      this.backImg = 'assets/images/ic_back_black.png',
      this.backImgColor,
      this.onPressed,
      this.isBack = true,
      this.textColor,
      this.backOnPressed,
      this.isNewIcon = false})
      : super(key: key);

  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final Color? backImgColor;
  final String actionName;
  final int? actionIconName;
  final VoidCallback? onPressed;
  final Color? textColor;
  final bool isBack;
  final VoidCallback? backOnPressed;
  final bool isNewIcon;
  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor = backgroundColor ?? context.backgroundColor;

    final SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    final Widget back = isBack
        ? IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (backOnPressed == null) {
                final isBack = await Navigator.maybePop(context);
                if (!isBack) {
                  await SystemNavigator.pop();
                }
              } else {
                backOnPressed!();
              }
            },
            tooltip: 'Back',
            padding: const EdgeInsets.all(12.0),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colours.text,
            ))
        : Gaps.empty;

    final Widget action = actionName.isNotEmpty
        ? Positioned(
            right: 0.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                buttonTheme: const ButtonThemeData(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  minWidth: 60.0,
                ),
              ),
              child: MyButton(
                key: const Key('actionName'),
                fontSize: Dimens.font_sp14,
                minWidth: null,
                text: actionName,
                textColor: textColor ?? Colours.text,
                backgroundColor: Colors.transparent,
                onPressed: onPressed,
              ),
            ),
          )
        : Gaps.empty;
    final Widget actionIcon = actionIconName != null
        ? Positioned(
            right: 20.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                buttonTheme: const ButtonThemeData(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  minWidth: 40.0,
                ),
              ),
              child: GestureDetector(
                onTap: onPressed,
                child: IconFont(
                    name: actionIconName ?? 0,
                    size: 20,
                    isNewIcon: isNewIcon,
                    color: textColor ?? Colours.material_bg),
              ),
            ),
          )
        : Gaps.empty;
    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(
          title.isEmpty ? centerTitle : title,
          style:
              TextStyles.textBold16.copyWith(color: textColor ?? Colours.text,fontWeight: FontWeight.bold),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              action,
              actionIcon,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
