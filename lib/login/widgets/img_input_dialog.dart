import 'dart:convert' as convert;

import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageInputDialog extends StatefulWidget {
  const ImageInputDialog({
    Key? key,
    this.imageBase64 = '',
    required this.onPressed,
    required this.imageTab,
  }) : super(key: key);
  final String imageBase64;
  final void Function(String, Function(String image)) onPressed;
  final void Function(Function(String image)) imageTab;

  @override
  _ImageInputDialogState createState() => _ImageInputDialogState();
}

class _ImageInputDialogState extends State<ImageInputDialog> {
  final TextEditingController _controller = TextEditingController();
  String _imageBase64 = '';
  @override
  void initState() {
    super.initState();
    _imageBase64 = widget.imageBase64;
  }

  @override
  void dispose() {
    _controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Picture verification code',
      rightTitle: 'Confirm',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.vGap10,
          InkWell(
            onTap: () {
              widget.imageTab((String image) {
                setState(() {
                  _imageBase64 = image;
                });
              });
            },
            child: _imageBase64.isNotEmpty
                ? Container(
                    padding: EdgeInsets.fromLTRB(16.0.w, 8.0.h, 16.0.w, 0.0.h),
                    width: double.infinity,
                    child: Image.memory(
                      const convert.Base64Decoder().convert(_imageBase64),
                      scale: 0.8,
                      fit: BoxFit.fill,
                    ),
                  )
                : Gaps.empty,
          ),
          Gaps.vGap10,
          Container(
            height: 34.0.h,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(16.0.w, 8.0.h, 16.0.w, 8.0.h),
            decoration: BoxDecoration(
              color: Colours.bg_color,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: TextField(
              key: const Key('Image_input'),
              autofocus: true,
              controller: _controller,
              maxLines: 1,
              maxLength: 4,
              style: TextStyles.textSize14,
              keyboardType: TextInputType.number,
              // inputFormatters: [
              //   FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]')),
              // ],
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
                border: InputBorder.none,
                hintText: 'Captcha',
                counterText: '',
                hintStyle:
                    TextStyles.textSize15.copyWith(color: Colours.text_gray_c),
              ),
            ),
          )
        ],
      ),
      onPressed: () {
        if (_controller.text.trim().isEmpty) {
          Toast.show('Please enter the Picture verification code');
          return;
        }
        if (_controller.text.trim().length < 4) {
          Toast.show('The verification code is incorrect');
          return;
        }
        widget.onPressed(_controller.text, (String image) {
          _controller.clear();
          setState(() {
            _imageBase64 = image;
          });
        });
      },
    );
  }
}
