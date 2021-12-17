import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyNewsPage extends StatefulWidget {
  const CompanyNewsPage({Key? key, required this.companyId}) : super(key: key);
  final String? companyId;

  @override
  _CompanyNewsPageState createState() => _CompanyNewsPageState();
}

class _CompanyNewsPageState extends State<CompanyNewsPage>
    with BasePageMixin<CompanyNewsPage, PowerPresenter>
    implements CompanyNewsIMvpView {
  @override
  BaseListProvider<BrandNewModel> companyNewsProvider =
      BaseListProvider<BrandNewModel>();

  late CompanyNewsPresenter _companyNewsPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyNewsPresenter = CompanyNewsPresenter();
    _companyNewsPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyNewsPresenter]);
    return powerPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<BrandNewModel>>(
            create: (_) => companyNewsProvider),
      ],
      child: Scaffold(
          backgroundColor: Colours.bg_color,
          appBar: const MyAppBar(
            centerTitle: 'News',
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: CardWidget(
              radius: 12.r,
              child: Consumer<BaseListProvider<BrandNewModel>>(
                builder: (_, provider, __) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: DeerListView(
                      key: const Key('new_list'),
                      itemCount: provider.list.length,
                      stateType: provider.stateType,
                      onRefresh: _companyNewsPresenter.onRefresh,
                      loadMore: _companyNewsPresenter.loadMore,
                      hasMore: provider.hasMore,
                      totalPages:
                          provider.metaModel?.pagination?.totalPages ?? 1,
                      itemBuilder: (_, index) {
                        return CompanyNewsItem(
                          model: provider.list[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }
}

class CompanyNewsItem extends StatelessWidget {
  const CompanyNewsItem({Key? key, this.model}) : super(key: key);
  final BrandNewModel? model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchWebURL('', model?.link ?? '', context),
      child: Container(
        color: Colours.material_bg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              child: Text(
                model!.title.toString(),
                style:
                    TextStyles.textBold15.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Text(
            //   'News·${model.publishTime} | ${model.source}',
            //   style: TextStyles.textGray10,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),

            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    '${model!.source ?? ''}',
                    style: TextStyles.textGray12,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Gaps.hGap8,
                  Text(
                    '${model!.publishTime ?? ''}',
                    style: TextStyles.textGray12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              child: Gaps.line,
            )
          ],
        ),
      ),
    );
  }

  void _launchWebURL(String title, String url, BuildContext context) {
    if (Device.isMobile) {
      NavigatorUtils.goWebViewPage(context, title, url);
    } else {
      Utils.launchWebURL(url);
    }
  }
}
