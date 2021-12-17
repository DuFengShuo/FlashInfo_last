import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/page/education/widget/education_cell.dart';
import 'package:flashinfo/personal/page/experience/widget/experience_cell.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EducationListPage extends StatefulWidget {
  final PeoplesNewBean? peoplesNewBean;
  const EducationListPage({Key? key, this.peoplesNewBean}) : super(key: key);

  @override
  _EducationListPageState createState() => _EducationListPageState();
}

class _EducationListPageState extends State<EducationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: const MyAppBar(
          centerTitle: 'Education',
        ),
        body:

        MyScrollView(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 17.h, horizontal: 16.w),
                padding: EdgeInsets.only(bottom: 12.h, top: 12.h),
                decoration: BoxDecoration(
                    color: Colours.material_bg,
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.peoplesNewBean!.education!.length,
                  itemBuilder: (_, index) {
                    Education education = widget.peoplesNewBean!.education![index];
                    return  EducationCell(isShowLine: index!=widget.peoplesNewBean!.education!.length-1,education: education,);
                  },
                )
            ),
          ],
        )

        );
  }
}
