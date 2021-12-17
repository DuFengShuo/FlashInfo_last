import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';

class HighlightTextWidget extends StatelessWidget {
  HighlightTextWidget(
      {Key? key, this.name = '', this.fontsize = 16, this.highlightText = ''})
      : super(key: key);
  //搜索的字符
  final String? name;
  final double fontsize;
  final String highlightText;
  //正常文本
  final TextStyle _normalStyle =
      TextStyles.textBold16.copyWith(color: Colours.text);

  //高亮文本
  final TextStyle _highlightStyle =
      TextStyles.textBold16.copyWith(color: Colours.app_main);

  ///返回设置好的富文本
  Widget _splitEnglish() {
    final List<TextSpan> spans = [];
    //split 截出来
    final List<String> strs = name!.split(' ');

    for (int i = 0; i < strs.length; i++) {
      //拿出字符串
      final String str = strs[i];
      if (str.toUpperCase() == highlightText.toUpperCase()) {
        spans.add(TextSpan(text: str + ' ', style: _highlightStyle));
      } else {
        spans.add(TextSpan(text: str + ' ', style: _normalStyle));
      }
    }
    //返回
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: spans),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _splitEnglish();
  }
}
