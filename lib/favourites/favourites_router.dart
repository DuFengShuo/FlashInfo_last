import 'package:fluro/fluro.dart';
import 'package:flashinfo/routers/i_router.dart';

import 'page/favourites_page.dart';
import 'page/group_list_page.dart';

class FavouritesRouter implements IRouterProvider {
  static String favouritesPage = '/favourites';
  static String groupListPage = '/favourites/groupList';
  @override
  void initRouter(FluroRouter router) {
    router.define(favouritesPage,
        handler: Handler(handlerFunc: (_, __) => const FavouritesPage()));

    router.define(groupListPage,
        handler: Handler(handlerFunc: (context, params) {
      final args = context?.settings?.arguments == null
          ? null
          : context!.settings!.arguments! as GroupListParam;
      return GroupListPage(groupListParam: args);
    }));
  }
}
