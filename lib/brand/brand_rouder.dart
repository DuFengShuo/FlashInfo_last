import 'dart:typed_data';

import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/page/brand_detail_page.dart';
import 'package:flashinfo/brand/page/brand_event_list_page.dart';
import 'package:flashinfo/brand/page/brand_list_page.dart';
import 'package:flashinfo/brand/widget/brand_screen_image_widget.dart';
import 'package:flashinfo/brand/widget/brand_tag_all_widget.dart';
import 'package:flashinfo/favourites/model/collects_list_beam.dart';
import 'package:flashinfo/routers/i_router.dart';
import 'package:fluro/fluro.dart';

class BrandRouder implements IRouterProvider {
  static String brandListPage = '/brandListPage';
  static String brandDetailPage = '/brandDetailPage';
  static String brandEventListPage = '/brandEventListPage';
  static String brandTagListWidget = '/brandTagListWidget';
  static String screenImageSave = '/screenImageSave';
  static String brandScrollView = '/brandScrollView';

  @override
  void initRouter(FluroRouter router) {
    router.define(brandListPage, handler: Handler(handlerFunc: (_, params) {
      final String keyword = params['keyword']?.first ?? '';
      return BandListPage(keyword: keyword);
    }));
    router.define(brandDetailPage,
        handler: Handler(handlerFunc: (context, params) {
      final String brandId = params['brandId']?.first ?? '';
      final String isToIndex = params['isToIndex']?.first ?? '';
      final args = context?.settings?.arguments == null
          ? null
          : context!.settings!.arguments! as BrandDetail;
      return BrandDetailPage(
        brandId: 'A7J2MLxKlVDR08ez',
        brandDetail: args,
        isToIndex: isToIndex,
      );
    }));

    router.define(brandEventListPage,
        handler: Handler(handlerFunc: (_, params) {
      final String? brandId = params['brandId']?.first ?? '';
      return BandEventListPage(
        brandId: brandId ?? '',
      );
    }));

    router.define(brandTagListWidget,
        handler: Handler(handlerFunc: (context, __) {
      final Overview overview =
          // ignore: cast_nullable_to_non_nullable
          context?.settings?.arguments as Overview;

      return BrandTagsAllWidget(
        overview: overview,
      );
    }));

    router.define(screenImageSave, handler: Handler(handlerFunc: (context, __) {
      final Uint8List? bytes =
          // ignore: cast_nullable_to_non_nullable
          context?.settings?.arguments as Uint8List;
      return ScreenImageSavePage(
        bytes: bytes,
      );
    }));
  }
}
