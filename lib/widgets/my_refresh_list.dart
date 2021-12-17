import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/login_unlock_view.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/theme_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'Layout/state_layout.dart';

/// 封装下拉刷新与加载更多
class DeerListView extends StatefulWidget {
  const DeerListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.onRefresh,
    this.loadMore,
    this.hasMore = false,
    this.stateType = StateType.empty,
    this.pageSize = 20,
    this.childLayout = Gaps.empty,
    this.isLogin = false,
    this.totalPages = 1,
    this.loginName = '',
    this.vipName = '',
    this.fuzzyImg = '',
  }) : super(key: key);

  final RefreshCallback? onRefresh;
  final LoadMoreCallback? loadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;
  final Widget childLayout;
  final int totalPages;
  final String fuzzyImg;

  /// 一页的数量，默认为20
  final int pageSize;

  final bool isLogin;
  final String loginName;
  final String vipName;

  @override
  _DeerListViewState createState() => _DeerListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _DeerListViewState extends State<DeerListView> {
  /// 是否正在加载数据
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Container(
        child: widget.itemCount == 0
            ? (widget.childLayout != Gaps.empty
                ? widget.childLayout
                : StateLayout(
                    type: widget.stateType, onRefresh: widget.onRefresh))
            : EasyRefresh.custom(
                header: BallPulseHeader(
                  color: Colours.app_main,
                ),
                footer: BallPulseFooter(
                  color: Colours.app_main,
                ),
                onRefresh: widget.onRefresh,
                onLoad: widget.itemCount % widget.pageSize > 0
                    ? null
                    : () async {
                        await _loadMore();
                      },
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        /// 不需要加载更多则不需要添加FootView
                        if (widget.loadMore == null) {
                          return widget.itemBuilder(context, index);
                        } else {
                          return index < widget.itemCount
                              ? widget.itemBuilder(context, index)
                              : MoreWidget(
                                  itemCount: widget.itemCount,
                                  hasMore: widget.hasMore,
                                  pageSize: widget.pageSize,
                                  totalPages: widget.totalPages,
                                  isLogin: widget.isLogin,
                                  loginName: widget.loginName,
                                  vipName: widget.vipName,
                                  fuzzyImg: widget.fuzzyImg,
                                  onRefresh: widget.onRefresh);
                        }
                      },
                      childCount: widget.loadMore == null
                          ? widget.itemCount
                          : widget.itemCount + 1,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _loadMore() async {
    if (widget.loadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }
    if (!widget.hasMore) {
      return;
    }
    _isLoading = true;
    await widget.loadMore!();
    _isLoading = false;
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget({
    Key? key,
    required this.itemCount,
    required this.hasMore,
    required this.pageSize,
    required this.totalPages,
    this.isLogin = false,
    this.onRefresh,
    this.loginName = '',
    this.vipName = '',
    this.fuzzyImg = '',
  }) : super(key: key);
  final int itemCount;
  final bool hasMore;
  final int pageSize;
  final bool isLogin;
  final RefreshCallback? onRefresh;
  final String loginName;
  final String vipName;
  final int totalPages;
  final String fuzzyImg;
  @override
  Widget build(BuildContext context) {
    final TextStyle style = context.isDark
        ? TextStyles.textGray14
        : const TextStyle(color: Color(0x8A000000));
    return isLogin
        ? LoginUnlockView(
            loginName: loginName,
            vipName: vipName,
            fuzzyImg: fuzzyImg,
            onTap: () {
              AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Login_Click');
              onRefresh!();
            },
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // if (hasMore) const CupertinoActivityIndicator(),
                // if (hasMore) Gaps.hGap5,

                /// 只有一页的时候，就不显示FooterView了
                Text(
                    hasMore
                        ? ''
                        : (totalPages > 1 ? 'Oops, no more information!' : ''),
                    style: style),
              ],
            ));
  }
}
