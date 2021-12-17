import 'dart:async';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/logo_container_widget.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyOrgChartPage extends StatefulWidget {
  const CompanyOrgChartPage({Key? key, this.companyId}) : super(key: key);
  final String? companyId;
  @override
  _CompanyOrgChartPageState createState() => _CompanyOrgChartPageState();
}

class _CompanyOrgChartPageState extends State<CompanyOrgChartPage>
    with BasePageMixin<CompanyOrgChartPage, PowerPresenter>
    implements StafflevelIMvpView {
  StreamSubscription? _subscription;
  Random r = Random();

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  late StafflevelPresenter _stafflevelPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _stafflevelPresenter = StafflevelPresenter();
    powerPresenter.requestPresenter([_stafflevelPresenter]);
    return powerPresenter;
  }

  List<LayerModel> layer = [];
  List<LayerModel> secondFloor = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        _stafflevelPresenter.companyStafflevel(widget.companyId ?? '',
            success: (StaffLevelModel model) {
          layer = model.layer ?? [];
          secondFloor = model.secondFloor ?? [];
          final List<Node> firstNode = [];
          final List<Node> secondNode = [];
          if (layer.isNotEmpty) {
            for (var i = 0; i < layer.length; i++) {
              firstNode.add(Node.Id(i));
            }
          }
          if (secondFloor.isNotEmpty) {
            for (var i = 0; i < secondFloor.length; i++) {
              secondNode.add(Node.Id(layer.length + i));
            }
          }
          for (var i = 0; i < secondFloor.length; i++) {
            graph.addEdge(firstNode.first, secondNode[i]);
          }
          setState(() {});
        });
        builder
          ..siblingSeparation = (25)
          ..levelSeparation = (25)
          ..subtreeSeparation = (25)
          ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT);
        // _subscription = Stream.value(1)
        //     .delay(const Duration(milliseconds: 500))
        //     .listen((_) {
        //   // 强制横屏
        //   SystemChrome.setPreferredOrientations([
        //     DeviceOrientation.landscapeLeft,
        //     DeviceOrientation.landscapeRight
        //   ]);
        // });
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /// 拦截返回，关闭键盘，否则会造成上一页面短暂的组件溢出
        FocusManager.instance.primaryFocus?.unfocus();
        return Future.value(true);
      },
      child: Scaffold(
          appBar: const MyAppBar(
            title: 'Org Chart',
          ),
          body: LogoContainerWidget(
            child: InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.01,
                maxScale: 5.6,
                child: GraphView(
                  graph: graph,
                  algorithm: BuchheimWalkerAlgorithm(
                      builder, TreeEdgeRenderer(builder)),
                  paint: Paint()
                    ..color = Colours.app_main
                    ..strokeWidth = 2
                    ..style = PaintingStyle.stroke,
                  builder: (Node node) {
                    final int a = node.key?.value as int;
                    final LayerModel? layerModel;
                    if (a <= layer.length - 1) {
                      layerModel = layer[a];
                    } else {
                      layerModel = secondFloor[a - layer.length];
                    }
                    return OrgChartItem(
                      a: a,
                      layerModel: layerModel,
                      isShowBorder: a == 0,
                    );
                  },
                )),
          )),
    );
  }
}

class OrgChartItem extends StatelessWidget {
  const OrgChartItem(
      {Key? key, this.a, this.layerModel, this.isShowBorder = false})
      : super(key: key);
  final int? a;
  final LayerModel? layerModel;
  final bool isShowBorder;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
          showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (_) => LoginToastDialog(onPressed: () {
                    Navigator.pop(context);
                    NavigatorUtils.push(context, LoginRouter.smsLoginPage);
                  }));
          return;
        }
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitUp,
        // ]);
        NavigatorUtils.pushResult(context,
            '${PersonalRouter.personalDetailsPage}?personalId=${layerModel?.id}',
            (value) {
          // 强制横屏
          // SystemChrome.setPreferredOrientations([
          //   DeviceOrientation.landscapeLeft,
          //   DeviceOrientation.landscapeRight
          // ]);
        });
      },
      child: Container(
        height: 96.h,
        width: 260.w,
        padding: EdgeInsets.only(
          top: 8.h,
          left: 8.w,
          right: 8.w,
        ),
        margin: EdgeInsets.only(left: 4.w),
        decoration: BoxDecoration(
            color: Colours.material_bg,
            border: new Border.all(
                color: isShowBorder ? Colours.app_main : Colours.material_bg,
                width: 4.w),
            //设置四周圆角 角度
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: const Color.fromRGBO(75, 75, 90, 0.1),
                  blurRadius: 5.0.r,
                  offset: const Offset(2.0, 2.0)),
            ]),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(color: Colours.bg_color, width: 2.w),
                  ),
                  child: LoadBorderImage(layerModel?.avatar ?? '',
                      width: 48.w,
                      height: 48.h,
                      holderImg: 'me/avatar',
                      radius: 24.r),
                ),
                Gaps.hGap8,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      layerModel?.name ?? '-',
                      style: TextStyles.textSize14
                          .copyWith(color: Colours.app_main),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.vGap4,
                    Text(layerModel?.positions ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textSize10),
                  ],
                ))
              ],
            ),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('点击电话');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.gap_dp4,
                            vertical: Dimens.gap_v_dp4),
                        child: IconFont(
                          isNewIcon: true,
                          name: 0xe63a,
                          color: (layerModel?.mobileCount ?? 0) > 0
                              ? Colours.app_main
                              : Colours.text_gray,
                          size: Dimens.font_sp20,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('点击邮箱');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.gap_dp4,
                            vertical: Dimens.gap_v_dp4),
                        child: IconFont(
                          isNewIcon: true,
                          name: 0xe632,
                          color: (layerModel?.emailCount ?? 0) > 0
                              ? Colours.app_main
                              : Colours.text_gray,
                          size: Dimens.font_sp20,
                        ),
                      ),
                    )
                  ],
                )),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.gap_dp5, vertical: Dimens.gap_v_dp2),
                  decoration: const BoxDecoration(
                    color: Colours.app_main,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Text(
                      '${(layerModel?.emailCount ?? 0) + (layerModel?.mobileCount ?? 0)}',
                      style: TextStyles.textSize10
                          .copyWith(color: Colours.material_bg)),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
