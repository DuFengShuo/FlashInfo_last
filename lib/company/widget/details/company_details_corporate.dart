import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/brand/widget/brand_company_widget.dart';
import 'package:flashinfo/brand/widget/brand_contact_widget.dart';
import 'package:flashinfo/brand/widget/brand_overview_widget.dart';
import 'package:flashinfo/brand/widget/brand_tag_widget.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/widget/bottomSheet/company_details_branches.dart';
import 'package:flashinfo/company/widget/bottomSheet/company_details_contact.dart';
import 'package:flashinfo/company/widget/details/company_details_benifits.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'company_details_item_header.dart';

class CompanyDetailsCorporate extends StatelessWidget {
  const CompanyDetailsCorporate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
      child: CardWidget(
          radius: 12.0.r,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              color: Colours.material_bg,
            ),
            // padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
            child: Consumer<BrandProvider>(
              builder: (_, provider, __) {

                //brandBean summary overview这三个类都做了非空断言表示不能为空，
                // Overview overview表示不能为空 Overview？ overview表示有可能为空
                 Overview? overview;
                if(provider.brandBean?.summary?.overview != null){
                 overview = provider.brandBean?.summary?.overview;
                }

                final int? founderLength = overview?.founders?.length??0;//overview不为空但有可能是个空类所以founders有可能为空,??表示为空时取右边的值
                final List<String> datas = [];
                datas.add(overview?.website ?? ''); //website有可能返回一个空字符串，这时候？？右边的就没用了
                datas.add(overview?.industry ?? '');
                datas.add(overview?.employeeSize ?? '');
                datas.add(overview?.ipo?.stockSymbol?.label ?? '');
                datas.add(founderLength.toString());
                datas.add(overview?.foundedDate ?? '');
                datas.add(overview?.lastFundingType ?? '');
                datas.add(overview?.headquartersLocation ?? '');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _industryWidget(
                      context,
                      datas,
                      overview?.tags ?? [],
                      overview?.benefit ?? [],
                      overview?.founders ?? [],
                      provider.brandBean!),
                );
              },
            ),
          )),
    );
  }

  List<Widget> _industryWidget(
      BuildContext context,
      List data,
      List<String> tags,
      List<String> benefit,
      List<Founders> founders,
      BrandBean brandBean) {
    final List<Widget> widgetArray = [];
    final List<String> title = [
      'Website',
      'Industry',
      'Size',
      'IPO Status',
      'Founders',
      'Founded Date',
      'Last Funding Type',
      'Headquarters Location'
    ];
    widgetArray.add(Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: const CompanyDetailsItemHeader(
        name: 'Summary',
        iconName: 0xe672,
      ),
    ));
    widgetArray.add(Gaps.line);

    widgetArray.add(Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 8.h,
      ),
      child: Text(
        'Overview',
        style: TextStyles.textBold14.copyWith(fontWeight: FontWeight.bold),
      ),
    ));

    widgetArray.add(OverviewWidget(
      titleList: title,
      dataList: data,
      foundList: founders,
      brandBean: brandBean,
    ));
    widgetArray.add(BrandTagWidget(tags: tags));
    widgetArray.add(const CompanyWelfare());
    widgetArray.add(Gaps.line);
    widgetArray.add(const BrandContactWidget());
    widgetArray.add(Gaps.line);
    widgetArray.add(const BrandCompanyWidget());
    return widgetArray;
  }

  void showBottomBranches(String companyId, BuildContext context) {
    //用于在底部打开弹框的效果
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return CompanyDetailsBranches(companyId: companyId);
        });
  }

  //显示底部弹框的功能
  // void showBottomSheet(String companyId, CompanyDetailModel? companyDetailModel,
  //     BuildContext context) {
  //   //用于在底部打开弹框的效果
  //   showModalBottomSheet<void>(
  //       context: context,
  //       backgroundColor: Colors.transparent,
  //       builder: (BuildContext context) {
  //         //构建弹框中的内容
  //         return CompanyDetailsContact(
  //             companyDetailModel: companyDetailModel, companyId: companyId);
  //       });
  // }
}
