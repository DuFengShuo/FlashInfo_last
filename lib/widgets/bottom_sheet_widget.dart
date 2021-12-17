import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget(
      {Key? key, required this.titleList, required this.onIndexTap})
      : super(key: key);
  final List<String> titleList;
  final Function(int) onIndexTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.material_bg,
      height: (titleList.length + 2) * 40.0 + 10.0,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: titleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(context, titleList[index], onTap: () {
                    onIndexTap(index);
                  });
                }),
          ),
          Gaps.lineV,
          //取消按钮
          //添加个点击事件
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: const Text('cancel'),
              height: 40,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, String title, {Function? onTap}) {
    //添加点击事件
    return InkWell(
      //点击回调
      onTap: () {
        //关闭弹框
        Navigator.of(context).pop();
        //外部回调
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.8),
          ),
        ),
        height: 40,
        //左右排开的线性布局
        child: Text(title),
      ),
    );
  }
}
