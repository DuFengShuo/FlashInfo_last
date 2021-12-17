import 'package:flashinfo/profile/model/export_bean.dart';
import 'package:fluro/fluro.dart';
import 'package:flashinfo/routers/i_router.dart';

import 'page/browsing/browsing_page.dart';
import 'page/business/business_center_page.dart';
import 'page/business/contact_list_page.dart';
import 'page/export/export_details_page.dart';
import 'page/export/export_history_page.dart';
import 'page/export/export_page.dart';
import 'page/export/export_success_page.dart';
import 'page/personal/person_employer_page.dart';
import 'page/personal/personal_job_page.dart';
import 'page/personal/personal_name_page.dart';
import 'page/personal/personal_page.dart';
import 'page/profile_page.dart';
import 'widget/input_text_page.dart';

class ProfileRouter implements IRouterProvider {
  static String profilePage = '/profile';
  static String personalPage = 'profile/personal';
  static String personalJobPage = 'profile/personal/personalJob';
  static String inputTextPage = 'profile/personal/inputText';
  static String personalNamePage = 'profile/personal/personalName';
  static String exportPage = '/export/export';
  static String exportHistoryPage = '/export/exportHistory';
  static String exportDetailsPage = '/export/exportHistory/exportDetails';
  static String exportSuccessPage = '/export/exportHistory/exportSuccess';

  static String browsingPage = '/profile/browsing';

  static String businessCenterPage = '/profile/businessCenter';
  static String contactListPage = '/profile/contactList';
  static String personEmployerPage = '/profile/personEmployer';

  @override
  void initRouter(FluroRouter router) {
    router.define(profilePage,
        handler: Handler(handlerFunc: (_, __) => const ProfilePage()));
    router.define(personalPage,
        handler: Handler(handlerFunc: (_, __) => const PersonalPage()));
    router.define(personalJobPage,
        handler: Handler(handlerFunc: (_, __) => const PersonalJobPage()));
    router.define(personalNamePage,
        handler: Handler(handlerFunc: (_, __) => const PersonalNamePage()));

    router.define(inputTextPage,
        handler: Handler(handlerFunc: (context, params) {
      final args = context?.settings?.arguments == null
          ? null
          : context!.settings!.arguments! as InputTextPageArgumentsData;
      return InputTextPage(
        inputTextPageArguments: args,
      );
    }));
    router.define(exportPage, handler: Handler(handlerFunc: (context, params) {
      final args = context?.settings?.arguments == null
          ? null
          : context!.settings!.arguments! as ExportStoreParams;
      return ExportPage(exportStoreParams: args);
    }));
    router.define(exportHistoryPage,
        handler: Handler(handlerFunc: (_, __) => const ExportHistoryPage()));
    router.define(exportDetailsPage,
        handler: Handler(handlerFunc: (context, params) {
      final model = context!.settings!.arguments! as ExportModel;
      return ExportDetailsPage(
        exportModel: model,
      );
    }));
    router.define(exportSuccessPage,
        handler: Handler(handlerFunc: (context, params) {
      final args = context?.settings?.arguments == null
          ? null
          : context!.settings!.arguments! as ExportModel;
      return ExportSuccessPage(exportModel: args);
    }));

    router.define(browsingPage,
        handler: Handler(handlerFunc: (_, __) => const BrowsingPage()));

    router.define(businessCenterPage,
        handler: Handler(handlerFunc: (_, params) {
      final String isShowLog = params['isShowLog']?.first ?? '';
      return BusinessCenterPage(isShowLog: isShowLog.isEmpty ? true : false);
    }));

    router.define(contactListPage,
        handler: Handler(handlerFunc: (_, __) => const ContactListPage()));

    router.define(personEmployerPage,
        handler: Handler(handlerFunc: (_, params) {
      final String? companyName = params['companyName']?.first ?? '';
      return PersonEmployerPage(companyName: companyName);
    }));
  }
}
