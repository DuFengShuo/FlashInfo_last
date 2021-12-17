import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CompanyDetailTopBarWidget extends StatefulWidget {
  final List? tabDatas;
  final Function? callBack;
  final ItemPositionsListener? itemPositionsListener;

  const CompanyDetailTopBarWidget(
      {Key? key, this.tabDatas, this.itemPositionsListener, this.callBack})
      : super(key: key);

  @override
  _CompanyDetailTopBarWidgetState createState() => _CompanyDetailTopBarWidgetState();
}

class _CompanyDetailTopBarWidgetState extends State<CompanyDetailTopBarWidget> {
  late ScrollController tableScroll;

  @override
  void initState() {
    super.initState();
    tableScroll = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Iterable<ItemPosition>>(
      valueListenable: widget.itemPositionsListener!.itemPositions,
      builder: (context, positions, child) {
        int min = 0;
        if (positions.isNotEmpty) {
          min = positions
              .where((ItemPosition position) => position.itemTrailingEdge > 0)
              .reduce((ItemPosition min, ItemPosition position) =>
          position.itemTrailingEdge < min.itemTrailingEdge
              ? position
              : min)
              .index;
        }

        return Container(
            height: 45.h,
            width: Screen.width(context),
            decoration: const BoxDecoration(
                color: Colours.material_bg,
              border: Border(top: BorderSide(width: 1,color: Colours.line))
            ),
            alignment: Alignment.center,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                // if(min==3){
                //   print('到这里了');
                //   // tableScroll.animateTo(
                //   //   0.0, //滚动到0,0就是底部（因为是反向的）
                //   //   curve: Curves.easeOut,
                //   //   duration: const Duration(milliseconds: 200),
                //   // );
                //   tableScroll.jumpTo(tableScroll.position.maxScrollExtent);
                // }
                return true;
              },
              child: ListView.builder(
                controller: tableScroll,
                padding: EdgeInsets.only(top: 0.1.h, left: 0),
                scrollDirection: Axis.horizontal,
                itemCount: widget.tabDatas!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        widget.callBack!(index);
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.only(top: 12, left: 18.w, right: 8.w),
                        child: Container(
                          color: Colours.material_bg,
                          child: Column(
                            children: [
                              Gaps.vGap5,
                              Text(
                                "${widget.tabDatas![index] ?? ""}",
                                style: TextStyles.textSize14.copyWith(
                                    color: min == index
                                        ? Colours.app_main
                                        : Colours.text_gray,
                                    fontWeight:
                                    min == index ? FontWeight.bold : null),
                              ),
                              // Gaps.vGap8,
                              const Expanded(child: Gaps.empty),
                              Container(
                                width: 32.w,
                                height: 4,
                                decoration: BoxDecoration(
                                    color: min == index
                                        ? Colours.app_main
                                        : Colors.transparent,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.r))
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ));
      },
    );
  }
}
