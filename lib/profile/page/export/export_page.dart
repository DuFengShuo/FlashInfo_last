import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/pay/pay_router.dart';
import 'package:flashinfo/profile/iview/export_iview.dart';
import 'package:flashinfo/profile/model/export_bean.dart';
import 'package:flashinfo/profile/presenter/export_presenter.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flashinfo/profile/widget/export/export_top_widget.dart';
import 'package:flashinfo/profile/widget/export/export_format_widget.dart';
import 'package:flashinfo/profile/widget/export/export_email_widget.dart';
import 'package:flashinfo/profile/widget/export/export_des_widget.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({Key? key, this.exportStoreParams}) : super(key: key);
  final ExportStoreParams? exportStoreParams;
  @override
  _ExportPageState createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage>
    with
        ChangeNotifierMixin<ExportPage>,
        BasePageMixin<ExportPage, PowerPresenter>
    implements ExportIMvpView {
  final FocusNode _nodeText = FocusNode();
  final FocusNode _node1Text = FocusNode();
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int _editCount = 0;
  int _maxNum = 0;
  bool _clickable = false;
  bool _isRecharge = false;
  @override
  BaseListProvider<ExportModel> exportListProvider =
      BaseListProvider<ExportModel>();
  late ExportPresenter _exportPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _exportPresenter = ExportPresenter();
    powerPresenter.requestPresenter([_exportPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = SpUtil.getString(Constant.email).nullSafe;
    if ((widget.exportStoreParams?.exportCount ?? 0) > 1000) {
      _editCount = 1000;
    } else {
      _editCount = widget.exportStoreParams?.exportCount ?? 0;
    }
    _maxNum = _editCount * 10;
    _numController.text = _editCount.toString();
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _numController: callbacks,
      _emailController: callbacks,
      _nodeText: null,
      _node1Text: null,
    };
  }

  void _verify() {
    final String count = _numController.text;
    final String email = _emailController.text;
    if (count.isNotEmpty && int.parse(count) != 0) {
      if (count.substring(0, 1) == '0') {
        _numController.text = _editCount.toString();
      }
      if (int.parse(count) > _maxNum / 10) {
        // ignore: division_optimization
        _numController.text = (_maxNum / 10).toInt().toString();
      }
    } else {
      _numController.text = '1';
    }

    setState(() {
      _editCount = int.parse(count.isEmpty ? '1' : int.parse(count).toString());
    });
    bool clickable = true;
    if (count.isEmpty) {
      clickable = false;
    }
    if (email.isEmpty) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  Future _confirm() async {
    AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Export_Click_Confirm');
    if (!Utils.isEmail(_emailController.text)) {
      showToast('Please enter the correct email address');
      return;
    }

    if (_isRecharge) {
      await SpUtil.putString(Constant.email, _emailController.text);
      final int count = widget.exportStoreParams?.exportCount ?? 0;
      widget.exportStoreParams?.exportCount = int.parse(_numController.text);
      widget.exportStoreParams?.email = _emailController.text;
      _exportPresenter.exportStore(widget.exportStoreParams,
          success: (ExportModel? bean) {
        if (bean != null) {
          NavigatorUtils.pushResult(context, ProfileRouter.exportSuccessPage,
              (value) {
            print(value);
          }, arguments: bean);
        } else {
          widget.exportStoreParams?.exportCount = count;
        }
      });
    } else {
      NavigatorUtils.pushResult(context,
          '${PayRouter.paymentPage}?exportCount=${_numController.text}',
          (value) {
        print(value);
      }, arguments: SkuIdType.csv);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(
        centerTitle: 'Confirm information',
      ),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(
            context, <FocusNode>[_nodeText, _node1Text]),
        children: _buildBody(),
        bottomButton: Container(
          decoration: BoxDecoration(
            color: Colours.material_bg,
            border: Border(
              top: Divider.createBorderSide(context, width: 5.h),
            ),
          ),
          padding: EdgeInsets.only(
              left: Dimens.gap_dp16,
              right: Dimens.gap_dp16,
              top: Dimens.gap_dp16),
          child: MyButton(
            key: const Key('Confirm'),
            minHeight: 45.h,
            onPressed: _clickable ? _confirm : null,
            text: 'Confirm',
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.line,
      ExportTopWidget(
          exportStoreParams: widget.exportStoreParams,
          emailController: _numController,
          node1Text: _node1Text,
          maxNum: _maxNum.toDouble()),
      Gaps.lineV,
      const ExportFormatWidget(),
      Gaps.lineV,
      ExportEmailWidget(
          exportStoreParams: widget.exportStoreParams,
          numController: _emailController,
          nodeText: _nodeText),
      Gaps.lineV,
      ExportDesWidget(
        count: _editCount,
        onTabCount: (bool isRecharge) {
          _isRecharge = isRecharge;
        },
      ),
    ];
  }
}

class ExportStoreParams {
  late int? exportCount;
  late String? email;
  late String? source;
  late String? url;
  late String? requestMethod;
  late String? searchCondition;
  late String? modelType;
  late String? viewCondition;
  late int? isSendMail;

  ExportStoreParams({
    this.exportCount,
    this.email,
    this.source,
    this.url,
    this.requestMethod,
    this.searchCondition,
    this.modelType,
    this.viewCondition,
    this.isSendMail,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (exportCount != null) {
      map['export_count'] = exportCount;
    }

    if (email != null) {
      map['email'] = email;
    }
    if (source != null) {
      map['source'] = source;
    }
    if (url != null) {
      map['url'] = url;
    }
    if (requestMethod != null) {
      map['request_method'] = requestMethod;
    }
    if (searchCondition != null) {
      map['search_condition'] = searchCondition;
    }
    if (modelType != null) {
      map['model_type'] = modelType;
    }
    if (viewCondition != null) {
      map['view_condition'] = viewCondition;
    }
    map['is_send_mail'] = 1;
    return map;
  }
}

enum ExportStoreType {
  /// 公司
  company,

  /// 人员
  personnel,

  /// 产品
  product,
}
