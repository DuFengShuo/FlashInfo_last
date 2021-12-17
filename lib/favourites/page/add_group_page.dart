import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddGroupPage extends StatelessWidget {
  AddGroupPage({Key? key, this.onPressed}) : super(key: key);
  final void Function(String)? onPressed;
  final FocusNode _nodeText = FocusNode();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      rightTitle: 'Save',
      title: 'New List',
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 44.w,
              decoration: BoxDecoration(
                // border: new Border.all(color: Colours.text_gray_c, width: 0),
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
              ),
              child: TextField(
                key: const Key('fund_input'),
                controller: _controller,
                focusNode: _nodeText,
                maxLines: 1,
                style: TextStyles.textSize13,
                keyboardType: TextInputType.text,
                maxLength: 50,
                autofocus: true,
                // 金额限制数字格式
                // inputFormatters: [
                //   FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))
                // ],
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.only(
                      top: 15.0.h, left: 15.0.w, right: 0.0.w, bottom: 15.0.h),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
                  hintStyle: TextStyles.textSize14.copyWith(
                    color: Colours.text_gray_c,
                  ),
                  hintText: '1-50characters',
                  fillColor: Colours.bg_color,
                  filled: true,
                ),
                onChanged: (value) {},
              ),
            ),
          ]),
      onPressed: () {
        if (_controller.text.trim().isEmpty) {
          Toast.show('The input field cannot be empty');
          return;
        }
        onPressed!(_controller.text.trim());
      },
    );
  }
}
