import 'dart:math';
import 'dart:typed_data';

import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ScreenImageSavePage extends StatefulWidget {
  final Uint8List? bytes;
  const ScreenImageSavePage({Key? key, this.bytes}) : super(key: key);

  @override
  _ScreenImageSavePageState createState() => _ScreenImageSavePageState();
}

class _ScreenImageSavePageState extends State<ScreenImageSavePage> {
  /// 保存图片
  static Future<void> saveImage(Uint8List byte, BuildContext context) async {
    var rng = new Random();//随机数生成类
    String nameRandom = rng.nextInt(10000).toString();
    await ImageGallerySaver.saveImage(byte, quality: 60, name: nameRandom+'brand');
    Toast.show('Successfully save');
    NavigatorUtils.goBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(
        centerTitle: 'Save image',
      ),
      body: MyScrollView(
        isSafeArea: false,
        bottomButton: Container(
          padding: EdgeInsets.only(top: Dimens.gap_dp8),
          alignment: Alignment.topCenter,
          height: 70.h,
          color: Colours.material_bg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: MyButton(
              text: 'Save',
              minHeight: 44.h,
              radius: 44.r,
              textColor: Colours.material_bg,
              fontSize: 12,
              backgroundColor: Colours.app_main,
              onPressed: () {
                saveImage(widget.bytes!, context);
              },
            ),
          ),
        ),
        children: [
          Image.memory(
            widget.bytes!,
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }
}
