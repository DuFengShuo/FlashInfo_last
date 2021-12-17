import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/login/widgets/my_text_field.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyRateReviewsPage extends StatefulWidget {
  const CompanyRateReviewsPage(
      {Key? key, required this.relatedId, required this.indexType})
      : super(key: key);
  final String relatedId;
  final int indexType;
  @override
  _CompanyRateReviewsPageState createState() => _CompanyRateReviewsPageState();
}

class _CompanyRateReviewsPageState extends State<CompanyRateReviewsPage>
    with
        ChangeNotifierMixin<CompanyRateReviewsPage>,
        BasePageMixin<CompanyRateReviewsPage, PowerPresenter>
    implements CompanyReviewsIMvpView {
  int _companyRelationship = 0;
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _nodeText2 = FocusNode();
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _nodeText3 = FocusNode();
  bool _clickable = false;
  late CommentStoreParams commentStoreParams = CommentStoreParams();
  late CompanyReviewsPresenter _companyReviewsPresenter;
  @override
  BaseListProvider<ReviewsModel> companyReviewsProvider =
      BaseListProvider<ReviewsModel>();
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyReviewsPresenter = CompanyReviewsPresenter();
    powerPresenter.requestPresenter([_companyReviewsPresenter]);
    return powerPresenter;
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _titleController: callbacks,
      _nodeText2: null,
      _nodeText3: null,
      _commentController: callbacks,
    };
  }

  @override
  void initState() {
    super.initState();
    commentStoreParams.type = widget.indexType;
    commentStoreParams.relatedId = widget.relatedId;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _verify() {
    final String title = _titleController.text.trim();
    final String _commentContext = _commentController.text.trim();
    bool clickable = true;
    if (title.isEmpty) {
      clickable = false;
    }

    if (_commentContext.isEmpty) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  Future _next() async {
    commentStoreParams.companyRelationship = _companyRelationship;
    commentStoreParams.title = _titleController.text.trim();
    commentStoreParams.comments = _commentController.text.trim();
    await _companyReviewsPresenter.commentStore(commentStoreParams,
        (ReviewsModel? model) {
      NavigatorUtils.goBackWithParams(context, model!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(
        centerTitle: 'Write your Review',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your review will be posted anonymously.',
              style: TextStyles.textGray12,
            ),
            Gaps.vGap8,
            Expanded(
              child: CardWidget(
                radius: 8.r,
                color: Colours.material_bg,
                child: MyScrollView(
                  keyboardConfig: Utils.getKeyboardActionsConfig(
                      context, <FocusNode>[_nodeText3, _nodeText2]),
                  padding: EdgeInsets.only(
                    left: Dimens.gap_dp16,
                    right: Dimens.gap_dp16,
                  ),
                  children: _buildBody(),
                ),
              ),
            ),
            Gaps.vGap16,
            SafeArea(
                child: MyButton(
              key: const Key('Submit'),
              minHeight: 44.h,
              radius: 22.h,
              onPressed: _clickable ? _next : null,
              text: 'Submit',
            )),
            Gaps.vGap10,
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.vGap16,
      Row(
        children: [
          Text(
            'Your relationship with this company ',
            style: TextStyles.textBold14.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '*',
            style: TextStyles.textSize12.copyWith(color: Colours.red),
          )
        ],
      ),

      Gaps.vGap16,
      Wrap(
        runSpacing: Dimens.gap_dp16,
        spacing: Dimens.gap_v_dp8,
        children: children(),
      ),
      Gaps.vGap16,
      Gaps.line,
      Gaps.vGap16,
      Row(
        children: [
          Text(
            'Review Headline ',
            style: TextStyles.textBold14,
          ),
          Text(
            '*',
            style: TextStyles.textSize12.copyWith(color: Colours.red),
          )
        ],
      ),

      Gaps.vGap20,
      MyTextField(
        focusNode: _nodeText2,
        controller: _titleController,
        maxLength: 120,
        hintText: 'Please insert your topic',
        onChanged: (value) async {},
      ),
      Gaps.vGap16,
      Row(
        children: [
          Text(
            'Comments',
            style: TextStyles.textBold14,
          ),
          Text(
            '*',
            style: TextStyles.textSize12.copyWith(color: Colours.red),
          )
        ],
      ),

      Gaps.vGap20,
      // Gaps.vGap8,
      TextField(
          maxLength: 2000,
          maxLines: 10,
          focusNode: _nodeText3,
          controller: _commentController,
          keyboardType: TextInputType.text,
          style: TextStyles.text.copyWith(fontSize: Dimens.font_sp14.sp),
          decoration: InputDecoration(
            fillColor: Colours.material_bg,
            hintText: 'Please insert your topic',
            border: InputBorder.none,
            hintStyle:
                TextStyles.textSize12.copyWith(color: Colours.text_gray_c),
          )),
    ];
  }

  List<Widget> children() {
    final List<Widget> arr = [];
    final List<String> list = [
      'Current employee',
      'Former employee',
      'Business Partner',
      'Others'
    ];
    for (var i = 0; i < list.length; i++) {
      arr.add(GestureDetector(
        onTap: () {
          setState(() {
            _companyRelationship = i;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _companyRelationship == i
                ? Colours.app_main
                : Colours.material_bg,
            borderRadius: BorderRadius.circular(22.0.h),
            border: Border.all(
              color: _companyRelationship == i
                  ? Colours.app_main
                  : Colours.bg_color,
              width: 1,
            ),
          ),
          width: (context.width - 100.w).w / 2,
          height: 44.h,
          padding: EdgeInsets.symmetric(
              vertical: Dimens.gap_v_dp4, horizontal: Dimens.gap_dp10),
          child: Text(
            list[i],
            style: TextStyles.textGray13.copyWith(
                color: _companyRelationship == i
                    ? Colours.material_bg
                    : Colours.text_gray),
          ),
        ),
      ));
    }
    return arr;
  }
}
