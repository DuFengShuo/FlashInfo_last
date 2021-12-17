import 'dart:async';

import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/theme_utils.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  final List<String> _guideList = Device.isIOS
      ? ['app_start_1', 'app_start_2', 'app_start_3']
      : ['app_start_01', 'app_start_02', 'app_start_03'];
  StreamSubscription? _subscription;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      await Device.initDeviceInfo();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)!) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(
              ImageUtils.getAssetImage(image, format: ImageFormat.webp),
              context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _subscription =
        Stream.value(1).delay(const Duration(milliseconds: 500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)! ||
          Constant.isDriverTest) {
        SpUtil.putBool(Constant.keyGuide, false);
        SpUtil.putBool(Constant.isFirstLogin, true);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  void _goLogin() {
    NavigatorUtils.push(context, Routes.home, clearStack: true);
  }

  // void _goGuide() {
  //   NavigatorUtils.push(context, GuideRouter.guideJobPage);
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.backgroundColor,
      child: _status == 0
          ? const FractionallyAlignedSizedBox(
              heightFactor: 0.3,
              widthFactor: 0.33,
              leftFactor: 0.33,
              bottomFactor: 0,
              child: LoadAssetImage('logo'))
          : Stack(
              children: <Widget>[
                Swiper(
                  key: const Key('swiper'),
                  itemCount: _guideList.length,
                  loop: false,
                  pagination: const SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      size: 10.0,
                      activeSize: 10.0,
                    ),
                  ),
                  itemBuilder: (_, index) {
                    return LoadAssetImage(
                      _guideList[index],
                      key: Key(_guideList[index]),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      format: ImageFormat.webp,
                    );
                  },
                  onIndexChanged: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  onTap: (index) {
                    if (index == _guideList.length - 1) {
                      _goLogin();
                    }
                  },
                ),
                Visibility(
                  visible: pageIndex != _guideList.length - 1,
                  child: Positioned(
                    right: 10.0,
                    top: 10.0,
                    child: GestureDetector(
                      child: SafeArea(
                          child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: Colors.white),
                            borderRadius: BorderRadius.circular(20.0)),
                        constraints: const BoxConstraints(
                            minWidth: 60.0,
                            maxWidth: 70.0,
                            minHeight: 20.0,
                            maxHeight: 30.0),
                        child: Text(
                          'skip',
                          style: TextStyle(
                              fontSize: Dimens.font_sp18, color: Colors.white),
                        ),
                      )),
                      onTap: () {
                        _goLogin();
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: pageIndex == _guideList.length - 1,
                  child: Positioned(
                    bottom: 40.0.h,
                    left: (context.width - 250.w) / 2,
                    child: GestureDetector(
                      child: SafeArea(
                          child: Container(
                        width: 250.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        decoration: BoxDecoration(
                            color: Colours.app_main,
                            border: Border.all(width: 0.6, color: Colors.white),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          'Go',
                          style: TextStyle(
                              fontSize: Dimens.font_sp18, color: Colors.white),
                        ),
                      )),
                      onTap: () {
                        _goLogin();
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
