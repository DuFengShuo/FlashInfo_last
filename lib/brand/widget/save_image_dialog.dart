import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/base_dialog.dart';
import 'package:flutter/material.dart';

class SaveImageToastDialog extends StatelessWidget {
  const SaveImageToastDialog({Key? key, this.onPressed}) : super(key: key);
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '“Flash Info”Would Like to Add to your Photos',
      rightTitle: 'OK',
      leftTitle: 'Don\'t Allow',
      textAlign: TextAlign.center,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp24, vertical: Dimens.gap_v_dp16),
        child: Text(
          'App needs to access your photo album to save the picture',
          style: TextStyles.textGray12,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
