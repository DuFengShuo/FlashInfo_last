import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/widget/details/gallery_example_item.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/gallery_photo_view.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'company_details_item_header.dart';

class CompanyDetailsAlbum extends StatelessWidget {
  const CompanyDetailsAlbum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvider>(
      builder: (_, provider, __) {
        final BrandBean? brandBean = provider.brandBean;
        final List<PhotosModel> list = provider.brandBean?.photos?.photoList ?? [];
        return Padding(
            padding:
                EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
            child: CardWidget(
                radius: 12.0.r,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Colours.material_bg,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimens.gap_dp16,
                        ),
                        child: CompanyDetailsItemHeader(
                            isNewIcon: true,
                            iconName: 0xe648,
                            name: 'Photos',
                            count: provider.brandBean?.photos?.total ?? 0,
                            onTap: (provider.brandBean?.photos?.total ?? 0) > 4
                                ? () {
                                    if (!(SpUtil.getBool(Constant.isLogin,
                                            defValue: false) ??
                                        false)) {
                                      showDialog<void>(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (_) =>
                                              LoginToastDialog(onPressed: () {
                                                Navigator.pop(context);
                                                NavigatorUtils.push(context,
                                                    LoginRouter.smsLoginPage);
                                              }));
                                      return;
                                    }
                                    NavigatorUtils.push(context,
                                        '${CompanyRouder.companyAlbumPage}?relatedId=${brandBean?.info?.id}');
                                  }
                                : null),
                      ),
                      if (list.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 16.h, left: 16.w, right: 16.w),
                          child: SizedBox(
                            width: double.infinity,
                            height: 20.h,
                            child: const Text(
                                'There are no Photos for this brand.'),
                          ),
                        )
                      else
                        AlbumListView(listData: list),
                      Gaps.vGap16,
                    ],
                  ),
                )));
      },
    );
  }
}

class AlbumListView extends StatefulWidget {
  const AlbumListView({Key? key, required this.listData}) : super(key: key);
  final List<PhotosModel>? listData;
  @override
  _AlbumListViewState createState() => _AlbumListViewState();
}

class _AlbumListViewState extends State<AlbumListView> {
  late List<GalleryExampleItem> galleryItems = <GalleryExampleItem>[];
  @override
  void initState() {
    super.initState();
    galleryItems.clear();
    widget.listData!.forEach((PhotosModel model) {
      galleryItems.add(
        GalleryExampleItem(
          id: model.id.toString(),
          resource: model.logo.toString(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        color: Colours.material_bg,
        height: 120.h,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            return true; //放开此行注释后，进度条将失效
          },
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 2.w, right: 10.w),
              scrollDirection: Axis.horizontal,
              itemCount: widget.listData!.length,
              itemBuilder: (BuildContext context, int index) {
                final PhotosModel? model = widget.listData![index];
                return GestureDetector(
                  onTap: () => openDialog(context, index),
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: 120.w,
                    height: 120.h,
                    child: LoadBorderImage(
                      model!.logo ?? '',
                      holderImg: 'company/company',
                      fit: BoxFit.fitWidth,
                      radius: 8.r,
                    ),
                  ),
                );
              }),
        ));
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
