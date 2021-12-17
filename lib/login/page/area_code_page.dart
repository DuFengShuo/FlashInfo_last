import 'package:azlistview/azlistview.dart';
import 'package:flashinfo/login/model/area_code_model.dart';
import 'package:flashinfo/login/page/code_model.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AreaCodePage extends StatefulWidget {
  const AreaCodePage({Key? key}) : super(key: key);

  @override
  _AreaCodePageState createState() => _AreaCodePageState();
}

class _AreaCodePageState extends State<AreaCodePage> {
  List<ContactInfo> _pinyinList = <ContactInfo>[];
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    List<AreaCodeModel> list = [];
    if (context.read<CommonProvider>().initializeModel != null) {
      list =
          context.read<CommonProvider>().initializeModel?.icon?.flagicon ?? [];
    }
    list.forEach((AreaCodeModel model) {
      if (model.code!.isNotEmpty && model.nameEn!.isNotEmpty) {
        final ContactInfo ci = new ContactInfo(
            name: model.nameEn ?? '',
            code: model.code,
            namePinyin: '',
            tagIndex: '',
            icon: model.icon);
        _pinyinList.add(ci);
      }
    });
    _handleList(_pinyinList);
  }

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;
    list.forEach((ContactInfo item) {
      final String pinyin = PinyinHelper.getPinyinE(item.name);
      final String tag = pinyin.substring(0, 1).toUpperCase();
      item.namePinyin = tag;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        item.tagIndex = tag;
      } else {
        item.tagIndex = '#';
      }
    });
    SuspensionUtil.sortListBySuspensionTag(list);
    SuspensionUtil.setShowSuspensionStatus(list);
    setState(() {
      _pinyinList = list;
    });
  }

  Decoration getIndexBarDecoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey[300]!, width: .5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'The area code',
      ),
      body: SafeArea(
        child: AzListView(
          data: _pinyinList,
          itemCount: _pinyinList.length,
          itemBuilder: (BuildContext context, int index) {
            final ContactInfo model = _pinyinList[index];
            return InkWell(
              onTap: () {
                NavigatorUtils.goBackWithParams(context, model.code.toString());
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: 40.0,
                child: Row(
                  children: <Widget>[
                    Gaps.hGap16,
                    CircleAvatar(
                      radius: 13.0.r,
                      backgroundColor: Colors.transparent,
                      backgroundImage: ImageUtils.getImageProvider(model.icon,
                          holderImg: 'none'),
                    ),
                    Gaps.hGap10,
                    Text(
                      '+${model.code}',
                      style: TextStyles.textSize15.copyWith(
                        color: Colours.app_main,
                      ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.hGap10,
                    Expanded(
                        child: Text(
                      model.name,
                      style: TextStyles.textSize15
                          .copyWith(color: Colours.app_main),
                    )),
                  ],
                ),
              ),
            );
          },
          physics: const BouncingScrollPhysics(),
          //列表头部
          susItemBuilder: (BuildContext context, int index) {
            final ContactInfo model = _pinyinList[index];
            final String indexName = model.getSuspensionTag();
            return Container(
              height: 30.h,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10.0.w),
              color: Colours.bg_color,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '$indexName',
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
            );
          },
          //中间index样式
          indexHintBuilder: (context, hint) {
            return Container(
              alignment: Alignment.center,
              width: 60.0,
              height: 60.0,
              decoration: const BoxDecoration(
                color: Colours.app_main,
                shape: BoxShape.circle,
              ),
              child: Text(hint,
                  style: const TextStyle(color: Colors.white, fontSize: 30.0)),
            );
          },
          indexBarMargin: EdgeInsets.only(right: 5.w),
          indexBarItemHeight: 20.h,
        ),
      ),
    );
  }
}
