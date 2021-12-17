import 'package:flashinfo/favourites/iview/tags_iview.dart';
import 'package:flashinfo/favourites/presenter/collects_presenter.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/base_dialog.dart';
import 'package:flutter/material.dart';

class CancelGroupPage extends StatefulWidget {
  const CancelGroupPage(
      {Key? key, this.relatedTd, this.indexType = 0, this.collectCancel})
      : super(key: key);
  final int indexType;
  final String? relatedTd;
  final Function(StatusModel)? collectCancel;
  @override
  _CancelGroupPageState createState() => _CancelGroupPageState();
}

class _CancelGroupPageState extends State<CancelGroupPage>
    with BasePageMixin<CancelGroupPage, PowerPresenter>
    implements CollectsIMvpView {
  late CollectsPresenter _collectsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _collectsPresenter = CollectsPresenter();
    _collectsPresenter.indexType = widget.indexType;
    powerPresenter.requestPresenter([_collectsPresenter]);
    return powerPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tips',
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
        child: Text(
          'Are you sure to cancel collection',
          style: TextStyles.textBold16,
        ),
      ),
      onPressed: () async {
        await _collectsPresenter.cancelCollectAll(widget.relatedTd,
            (StatusModel statusModel) {
          NavigatorUtils.goBack(context);
          widget.collectCancel!(statusModel);
        });
      },
    );
  }
}
