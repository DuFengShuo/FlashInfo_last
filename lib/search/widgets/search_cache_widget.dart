import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchCacheWidget extends StatefulWidget {
  const SearchCacheWidget(
      {Key? key, this.localTextSubject, required this.onCacheItem})
      : super(key: key);

  final PublishSubject<String>? localTextSubject;
  final Function(String) onCacheItem;
  @override
  _SearchCacheWidgetState createState() => _SearchCacheWidgetState();
}

class _SearchCacheWidgetState extends State<SearchCacheWidget> {
  ///本地记录
  List<Widget> localList = [];
  @override
  void initState() {
    super.initState();
    if (widget.localTextSubject != null) {
      widget.localTextSubject!.listen((value) {
        getLocal();
      });
    }
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        getLocal();
      },
    );
  }

  void getLocal() {
    if (SpUtil.getStringList(Constant.localList) != null) {
      if (mounted) {
        setState(() {
          localList = SpUtil.getStringList(Constant.localList)!
              .map((value) => chileItem(value))
              .toList();
        });
      }
    } else {
      if (mounted) {
        setState(() {
          localList = [];
        });
      }
    }
  }

  Widget chileItem(String value) {
    return InkWell(
      onTap: () => widget.onCacheItem(value),
      child: Container(
        constraints: BoxConstraints(maxWidth: 170.0.w),
        decoration: BoxDecoration(
          color: Colours.bg_color,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.textGray12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return localList.isEmpty
        ? const StateLayout(type: StateType.empty)
        : Container(
            color: Colours.material_bg,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (localList.isEmpty)
                    Gaps.empty
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Search History',
                            style: TextStyles.textSize16.copyWith(
                                color: Colours.app_main,
                                fontWeight: FontWeight.w500)),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: IconFont(
                                name: 0xe60a,
                                size: 14.sp,
                                color: Colours.unselected_item_color),
                          ),
                          onTap: () {
                            SpUtil.putStringList(Constant.localList, []);
                            setState(() {
                              localList = [];
                            });
                          },
                        )
                      ],
                    ),
                  Gaps.line,
                  Gaps.vGap15,
                  Wrap(
                    runSpacing: 15.0.h,
                    spacing: 10.0.w,
                    children: localList,
                  ),
                  Gaps.vGap15,
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colours.bg_color,
                      child: Gaps.empty,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
