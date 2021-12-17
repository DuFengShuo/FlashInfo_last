import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BrandContactWidget extends StatelessWidget {
  const BrandContactWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvider>(builder: (_, provider, __) {
      final BrandBean? brandBean = provider.brandBean;
      final List<String> title = [
        'Phone Number',
        'Email',
        'Address',
      ];
      final List<String> content = [];
      final ContactInfo? contact_info = brandBean!.summary!.contactInfo;
      content.add(contact_info?.phoneNumber ?? '');
      content.add(contact_info?.email ?? '');
      content.add(contact_info?.address ?? '');
      return Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Info',
              style:
                  TextStyles.textBold14.copyWith(fontWeight: FontWeight.bold),
            ),
            // Gaps.vGap24,
            ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 24.h),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: title.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == title.length - 1) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.textGray12,
                        ),
                        Gaps.vGap8,
                        Text(
                          '${content.last.isEmpty ? '-' : content.last}',
                          style: TextStyles.textSize12,
                        ),
                        Gaps.vGap20,
                      ],
                    );
                  } else
                    return Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Row(
                        children: [
                          Text(
                            '${title[index]}',
                            style: TextStyles.textGray12,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (index == 0 && content[index].isNotEmpty) {
                                Utils.launchTelURL('${content[index]}');
                              }
                            },
                            child: Text(
                              '${content[index].toString().isEmpty ? '-' : content[index]}',
                              style: index == 0
                                  ? TextStyles.textSize12.copyWith(
                                      color: Colours.app_main,
                                      fontWeight: FontWeight.bold)
                                  : TextStyles.textSize12,
                            ),
                          )
                        ],
                      ),
                    );
                }),
          ],
        ),
      );
    });
  }
}
