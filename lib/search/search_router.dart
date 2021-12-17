import 'package:fluro/fluro.dart';
import 'package:flashinfo/routers/i_router.dart';

import 'page/search_cache_page.dart';
import 'page/search_page.dart';

class SearchRouter implements IRouterProvider {
  static String searchPage = '/search';
  static String searchCachePage = '/search/SearchCache';

  @override
  void initRouter(FluroRouter router) {
    router.define(searchPage, handler: Handler(handlerFunc: (_, params) {
      final int? indexType = int.parse(params['indexType']?.first ?? '0');
      final String? searchValue = params['searchValue']?.first ?? '';
      final String? otherString = params['otherString']?.first ?? '';
      return SearchPage(
        indexType: indexType,
        searchValue: searchValue,
        otherString: otherString,
      );
    }));
    router.define(searchCachePage,
        handler: Handler(handlerFunc: (_, __) => const SearchCachePage()));
  }
}
