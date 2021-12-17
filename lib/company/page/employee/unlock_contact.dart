import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/base_dialog.dart';
import 'package:flutter/material.dart';

class UnlockContact extends StatelessWidget {
  const UnlockContact(
      {Key? key,
      this.onPressed,
      this.name,
      this.companyName,
      this.companyAvatar,
      this.position,
      this.avatar})
      : super(key: key);
  final void Function()? onPressed;
  final String? name;
  final String? companyName;
  final String? companyAvatar;
  final String? position;
  final String? avatar;
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Please confirm you want to unlock this contact.',
      rightTitle: 'Confirm',
      textAlign: TextAlign.center,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp20, vertical: Dimens.gap_v_dp10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name：', style: TextStyles.textGray12),
                  Expanded(
                      child: Text(name!.isEmpty?'-':name??'',
                          textAlign: TextAlign.right,
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyles.textSize12))
                ],
              ),
              Gaps.vGap16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title：', style: TextStyles.textGray12),
                  Expanded(
                      child: Text(position!.isEmpty?'-':position??'',
                          textAlign: TextAlign.right,
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyles.textSize12))
                ],
              ),
            ]),
      ),
      onPressed: onPressed,
    );
  }
}
