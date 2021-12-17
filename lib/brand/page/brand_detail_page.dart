import 'package:flashinfo/brand/iview/brand_detail_iview.dart';
import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/page/brand_detail_scrollview.dart';
import 'package:flashinfo/brand/presenter/brand_detail_presenter.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/favourites/model/collects_list_beam.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandDetailPage extends StatefulWidget {
  const BrandDetailPage({Key? key, required this.brandId, this.brandDetail, this.isToIndex})
      : super(key: key);
  final String brandId;
  final BrandDetail? brandDetail;
  final String? isToIndex;
  @override
  _BrandDetailPageState createState() => _BrandDetailPageState();
}

class _BrandDetailPageState extends State<BrandDetailPage>
    with BasePageMixin<BrandDetailPage, PowerPresenter>
    implements BrandDetailIMvpView {
  late BrandDetailPresenter _brandDetailPresenter;

  @override
  BrandProvider brandProvider = BrandProvider();

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _brandDetailPresenter = BrandDetailPresenter();
    powerPresenter.requestPresenter([_brandDetailPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    brandProvider.setStateType(StateType.detailLayout); //默认加载条
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        await _brandDetailPresenter.getBrandDetail(widget.brandId); //获取品牌详情数据
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BrandProvider>(
        create: (_) => brandProvider,
        child: Consumer<BrandProvider>(builder: (_, provider, __) {
          final BrandBean? model = provider.brandBean;

          return Scaffold(
              body: model == null
                  ? StateLayout(
                      type: provider.stateType,
                    )
                  : BrandDetailScrollView(
                      brandDetail: widget.brandDetail,
                      model: model,
                      brandDetailPresenter: _brandDetailPresenter,
                isToOfficer: (widget.isToIndex!=null && widget.isToIndex!.isNotEmpty)?true:false,

              ));
        }));
  }
}
