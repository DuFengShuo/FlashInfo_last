import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/util/theme_utils.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'head_animation_layout.dart';
import 'list_animation_layout.dart';

/// design/9暂无状态页面/index.html#artboard3
class StateLayout extends StatelessWidget {
  const StateLayout(
      {Key? key, required this.type, this.hintText, this.onRefresh})
      : super(key: key);

  final StateType type;
  final String? hintText;
  final Future<void> Function()? onRefresh;
  @override
  Widget build(BuildContext context) {
    if (type == StateType.listLayout) {
      return const ListAnimationLayout();
    } else if (type == StateType.detailLayout) {
      return const HeadAnimationLayout();
    } else {
      return _defaultLayout();
    }
  }

  Widget _defaultLayout() {
    return EasyRefresh.custom(
      header: BallPulseHeader(
        color: Colours.app_main,
      ),
      onRefresh: onRefresh,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return SizedBox(
                width: double.infinity,
                height: Screen.height(context) - 300.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (type == StateType.loading)
                      const CupertinoActivityIndicator(radius: 16.0)
                    else if (type != StateType.empty)
                      Opacity(
                        opacity: context.isDark ? 0.5 : 1,
                        child: LoadAssetImage(
                          'state/${type.img}',
                          width: 120,
                        ),
                      ),
                    SizedBox(
                      width: double.infinity,
                      height: Dimens.gap_dp16,
                    ),
                    Text(
                      hintText ?? type.hintText,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

enum StateType {
  /// 公司
  company,

  /// 人员
  personnel,

  /// 产品
  product,

  ///引导
  leads,

  /// 无网络
  network,

  /// 消息
  message,

  /// 加载中
  loading,

  /// 空
  empty,

  ///动态占位
  listLayout,

  ///详情
  detailLayout,

  ///导出数据
  exportHistory,
}

extension StateTypeExtension on StateType {
  String get img => <String>[
        'company',
        'personnel',
        'product',
        'leads',
        'zwwl',
        'zwxx',
        '',
        '',
        '',
        '',
        'exportHistory'
      ][index];

  String get hintText => <String>[
        'No data',
        'No data',
        'No data',
        'No data',
        'No Internet connection',
        'No data',
        '',
        '',
        '',
        '',
        'No data',
      ][index];
}
