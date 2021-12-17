import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/base_dialog.dart';
import 'package:flutter/material.dart';

class LoginToastDialog extends StatelessWidget {
  const LoginToastDialog({Key? key, this.onPressed}) : super(key: key);
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tips',
      rightTitle: 'Log in',
      textAlign: TextAlign.center,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp20, vertical: Dimens.gap_v_dp24),
        child: Text(
          'Please log in before using this feature',
          style: TextStyles.textSize16,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
