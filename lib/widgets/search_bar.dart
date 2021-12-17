import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/theme_utils.dart';
import 'package:rxdart/subjects.dart';

/// 搜索页的AppBar
class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({
    Key? key,
    this.hintText = '',
    this.backImg = 'assets/images/ic_back_black.png',
    this.onPressed,
    this.onChanged,
    this.searchValue = '',
    this.searchBarsubject,
    this.autofocus = false,
  }) : super(key: key);

  final String backImg;
  final String hintText;
  final Function(String)? onPressed;
  final Function(String)? onChanged; //监听输入框
  final String searchValue;
  final PublishSubject<String>? searchBarsubject;
  final bool autofocus;

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    _controller.text = widget.searchValue;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      widget.searchBarsubject!.listen((value) {
        if (value != null && value.isNotEmpty) {
          _controller.text = value.toString();
        }
      });
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color iconColor =
        isDark ? Colours.dark_text_gray : Colours.text_gray_c;

    final Widget back = Semantics(
      label: '返回',
      child: SizedBox(
        width: 40.0,
        height: 48.0,
        child: InkWell(
          onTap: () {
            _focus.unfocus();
            Navigator.maybePop(context);
          },
          borderRadius: BorderRadius.circular(24.0),
          child: const Padding(
            key: Key('search_back'),
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colours.text,
            ),
          ),
        ),
      ),
    );

    final Widget textField = Expanded(
      child: Container(
        height: 32.0,
        decoration: BoxDecoration(
          color: isDark ? Colours.dark_material_bg : Colours.bg_gray,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: TextField(
          key: const Key('search_text_field'),
          autofocus: widget.autofocus,
          controller: _controller,
          focusNode: _focus,
          maxLines: 1,
          textInputAction: TextInputAction.search,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))
          ],
          onChanged: widget.onChanged,
          onSubmitted: (String val) {
            _focus.unfocus();
            // 点击软键盘的动作按钮时的回调
            widget.onPressed?.call(val);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
                top: 0.0, left: -8.0, right: 8.0, bottom: 14.0),
            border: InputBorder.none,
            icon: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
                child: IconFont(name: 0xe60b, size: 14, color: iconColor)),
            hintText: widget.hintText,
          ),
        ),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Material(
        color: context.backgroundColor,
        child: SafeArea(
          child: Row(
            children: <Widget>[
              back,
              textField,
              Gaps.hGap16,
            ],
          ),
        ),
      ),
    );
  }
}
