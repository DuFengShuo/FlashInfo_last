import 'package:flashinfo/brand/widget/save_image_dialog.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class BrandSharePage extends StatefulWidget {
  final String? brandWebUrlId;
  final Function? callBack;
  final String? phoneNum;
  final String? name;
  final bool? isPersonnel;
  const BrandSharePage(
      {Key? key, this.brandWebUrlId, this.callBack, this.phoneNum, this.name,  this.isPersonnel})
      : super(key: key);

  @override
  _BrandSharePageState createState() => _BrandSharePageState();
}

class _BrandSharePageState extends State<BrandSharePage> {

  @override
  Widget build(BuildContext context) {
    String webUrl = '';
    String apiAddress = '';
    switch (Constant.baseUrl) {
      case Constant.testUrl:
        apiAddress = 'http://172.31.3.209:7003/';
        break;
      case Constant.mastOnLineUrl:
        apiAddress = 'https://stag-www.myflashinfo.com/';
        break;
      case Constant.onLineUrl:
        apiAddress = 'https://www.myflashinfo.com/';
        break;
      default:
        apiAddress = 'https://www.myflashinfo.com/';
    }

    if(widget.isPersonnel!=null && widget.isPersonnel==true){
      webUrl= '${apiAddress}contact/details?id=';
    } else {
      webUrl= '${apiAddress}company/details?id=';
    }

    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
      height: 220.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: Colours.material_bg,
      ),
      width: Screen.width(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 10.w),
              child: Text(
                'Share',
                style: TextStyles.textBold18,
              )),
          Gaps.vGap18,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // InkWell(
              //   onTap: () async {
              //     Navigator.pop(context);
              //     // var status = await Permission.mediaLibrary.status;
              //     // if (status.isDenied==false) {
              //       // We didn't ask for permission yet or the permission has been denied before but not permanently.
              //
              //
              //       // Permission.mediaLibrary.isDenied= true;
              //     // }
              //     // else {
              //     //   widget.callBack!();
              //     // }
              //   },
              //   child: const ShareRowWidget(
              //     bgColor: Colours.app_main,
              //     title: 'Save image',
              //     iconName: 'share_img',
              //   ),
              // ),
              InkWell(
                  onTap: () {
                    //https://stag-www.myflashinfo.com/company/details?id=EPBjrRZz7yAR38qY
                    final String barnUrl =
                        '$webUrl${widget.brandWebUrlId}';
                    //复制
                    Clipboard.setData(ClipboardData(text: barnUrl));
                    //读取
                    //var text = Clipboard.getData(Clipboard.kTextPlain);
                    Navigator.pop(context);
                    Toast.show('Copied to clipboard!');
                  },
                  child: const ShareRowWidget(
                    bgColor: Colours.highlight,
                    title: 'Copy Link',
                    iconName: 'share_cl',
                  )),
              Visibility(
                visible: Device.isAndroid,
                child: InkWell(
                    onTap: () async {
                      final String barnUrl =
                          '[Flash info] ${widget.name}: $webUrl${widget.brandWebUrlId}';

                      if (Device.isAndroid) {
                        final String uri = 'sms:?body=$barnUrl';
                        await launch(uri);
                      } else if (Device.isIOS) {
                        // iOS
                        final String uri = 'sms:&body=$barnUrl';
                        await launch(uri);
                      }
                    },
                    child: const ShareRowWidget(
                      bgColor: Colours.text_043,
                      title: 'Messages',
                      iconName: 'share_message',
                    )),
              ),

              InkWell(
                  onTap: () async {
                    final String barnUrl =
                        //  '[Flash info]${widget.name}  https://stag-www.myflashinfo.com/company/details?id=${widget.brandWebUrlId}';
                        '$webUrl${widget.brandWebUrlId}';
                    final response = await FlutterShareMe().shareToTwitter(
                        url: barnUrl, msg: '[Flash info]${widget.name}');
                    if (response == 'Sucess') {
                      print('navigate success');
                    } else {
                      Toast.show('No Application is installed');
                    }
                  },
                  child: const ShareRowWidget(
                    bgColor: Colours.bg_1f2,
                    title: 'Twitter',
                    iconName: 'share_twitter',
                  )),
            ],
          ),
          Gaps.vGap24,
          GestureDetector(
            onTap: () {
              NavigatorUtils.goBack(context);
            },
            child: Container(
              alignment: Alignment.center,
              height: 44.h,
              width: Screen.width(context),
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colours.border_grey),
                  borderRadius: BorderRadius.all(Radius.circular(44.h))),
              child: Text(
                'Cancel',
                style: TextStyles.text,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class ShareRowWidget extends StatelessWidget {
  final Color? bgColor;
  final String? title;
  final String? iconName;

  const ShareRowWidget({Key? key, this.bgColor, this.title, this.iconName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(56.r)),
              color: bgColor),
          width: 56.w,
          height: 56.w,
          child: Center(
            child: Image(
              width: 24.w,
              height: 24.w,
              fit: BoxFit.fitHeight,
              image: ImageUtils.getAssetImage('brand/$iconName'),
            ),
          ),
        ),
        Gaps.vGap4,
        Text(
          '$title',
          style: TextStyles.textGray10,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
