import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SkillListPage extends StatefulWidget {
   final  List<Skills>? skills;
  const SkillListPage({Key? key,this.skills}) : super(key: key);

  @override
  _SkillListPageState createState() => _SkillListPageState();
}

class _SkillListPageState extends State<SkillListPage> {
  PersonalProvider personalProvider = new PersonalProvider();
    late final List<String> dataList;
  @override
  void initState() {
    super.initState();
    final List<String> skillList = [];

    for(int i =0; i<widget.skills!.length; i++){
      Skills skillee = widget.skills![i];
      skillList.add(skillee.name??'');
    }
    dataList = Utils.maopaoList(skillList);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: const MyAppBar(
          centerTitle: 'Skills',
        ),
        body:
           MyScrollView(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 16.h, top: 16.h),
                  child: CardWidget(
                      radius: 12.0.r,
                      child: Container(
                          color: Colours.material_bg,
                          // height: 400.h,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Wrap(
                              spacing: 8.w, //主轴上子控件的间距
                              runSpacing: 8.0.h, //交叉轴上子控件之间的间距
                              children: dataList.map((e) =>
                                  _borderText('$e')
                              ).toList(),
                              //要显示的子控件集合
                              clipBehavior: Clip.antiAlias,
                            ),
                          ))))
            ],
          )
        );
  }


  Widget _borderText(
      String text) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Container(
        // height: 32.h,
        // alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp5),
        // constraints: BoxConstraints(maxWidth: 80.w),
        decoration: BoxDecoration(
          color: Colours.line,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(32.0.r)),
          //设置四周边框
          // border: new Border.all(
          //     width: isIndustry ? 0 : 0.6.w, color: Colours.material_bg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth:Screen.width(context)-100.w
            ),
            child: Text(
              text,
              maxLines: 200,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colours.text_gray,
                fontSize: Dimens.font_sp12,
                height: 1.3
              ),
            ),
          ),
        ),
      ),
    );
  }
}
