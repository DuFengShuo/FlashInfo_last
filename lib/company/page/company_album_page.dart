import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/albums_bean.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/company/widget/details/gallery_example_item.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/gallery_photo_view.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flashinfo/util/screen_utils.dart';

class CompanyAlbumPage extends StatefulWidget {
  const CompanyAlbumPage({Key? key, required this.relatedId}) : super(key: key);
  final String? relatedId;
  @override
  _CompanyAlbumPageState createState() => _CompanyAlbumPageState();
}

class _CompanyAlbumPageState extends State<CompanyAlbumPage>
    with BasePageMixin<CompanyAlbumPage, PowerPresenter>
    implements CompanyAlbumsIMvpView {
  @override
  BaseListProvider<AlbumsModel> companyAlbumsProvider =
      BaseListProvider<AlbumsModel>();
  @override
  late List<GalleryExampleItem> galleryItems = <GalleryExampleItem>[];
  late CompanyAlbumsPresenter _companyAlbumsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyAlbumsPresenter = CompanyAlbumsPresenter();
    _companyAlbumsPresenter.companyId = widget.relatedId ?? '';
    powerPresenter.requestPresenter([_companyAlbumsPresenter]);
    return powerPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<AlbumsModel>>(
            create: (_) => companyAlbumsProvider),
      ],
      child: Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: const MyAppBar(
          centerTitle: 'Photos',
        ),
        body: Consumer<BaseListProvider<AlbumsModel>>(
          builder: (_, provider, __) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: context.width / 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: Dimens.gap_dp5,
                      mainAxisSpacing: Dimens.gap_dp5),
                  itemCount: provider.list.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final AlbumsModel model = provider.list[index];
                    return GestureDetector(
                      onTap: () => openDialog(context, index),
                      child: LoadBorderImage(model.logo ?? '',
                          radius: 15.w, holderImg: 'product/product'),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }

  List<Widget> children(List<AlbumsModel> list) {
    final List<Widget> arr = [];
    list.forEach((AlbumsModel model) {
      arr.add(GestureDetector(
        child: LoadBorderImage(model.logo ?? '',
            width: (context.width - 55.w).w / 3,
            height: (context.width - 42.w).w / 3,
            radius: 10.w,
            holderImg: 'product/product'),
      ));
    });
    return arr;
  }

  void openDialog(BuildContext context, final int index) => showDialog<void>(
        context: context,
        barrierColor: const Color(0xbf000000),
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              NavigatorUtils.goBack(context);
            },
            child: GalleryPhotoViewWrapper(
              galleryItems: galleryItems,
              initialIndex: index,
              scrollDirection: Axis.horizontal,
            ),
          );
        },
      );
}
