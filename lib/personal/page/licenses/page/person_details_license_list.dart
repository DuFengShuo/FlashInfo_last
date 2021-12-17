import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/page/licenses/widget/person_licenses_cell.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LicensesListPage extends StatefulWidget {
  final PeoplesNewBean? model;

  const LicensesListPage({Key? key, this.model}) : super(key: key);

  @override
  _LicensesListPageState createState() => _LicensesListPageState();
}

class _LicensesListPageState extends State<LicensesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(
        centerTitle: 'Licenses & Certifications',
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
                   itemCount: widget.model!.honors!.length,
                   itemBuilder: (BuildContext context, int index) {
                     Honors heroMode = widget.model!.honors![index];
                     return LicensesCell(
                       isShowLine: index != widget.model!.honors!.length-1,
                       honors: heroMode,
                     );
                   })
           ),
         ],
       )

    );
  }
}
