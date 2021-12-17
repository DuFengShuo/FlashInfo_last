import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/models/albums_bean.dart';
import 'package:flashinfo/company/models/company_contact_model.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/models/company_subsidiary_model.dart';
import 'package:flashinfo/company/models/finance_rounds_bean.dart';
import 'package:flashinfo/company/models/investments_bean.dart';
import 'package:flashinfo/company/models/investors_bean.dart';
import 'package:flashinfo/company/models/unlock_contact_model.dart';
import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/dashboard/models/recommend_bean.dart';
import 'package:flashinfo/favourites/model/collects_list_beam.dart';
import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/home/model/initialize_model.dart';
import 'package:flashinfo/login/model/area_code_model.dart';
import 'package:flashinfo/login/model/captcha_email_model.dart';
import 'package:flashinfo/login/model/captcha_img_model.dart';
import 'package:flashinfo/login/model/captcha_sms_model.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/pay/model/go_pay_bean.dart';
import 'package:flashinfo/pay/model/pay_ments_list_bean.dart';
import 'package:flashinfo/personal/model/colleagues_bean.dart';
import 'package:flashinfo/personal/model/educations_bean.dart';
import 'package:flashinfo/personal/model/honors_bean.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/model/person_work_bean.dart';
import 'package:flashinfo/personal/model/personal_details_bean.dart';
import 'package:flashinfo/personal/model/works_bean.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/product/model/products_details_bean.dart';
import 'package:flashinfo/profile/model/browsing_bean.dart';
import 'package:flashinfo/profile/model/export_bean.dart';
import 'package:flashinfo/profile/model/people_unlock_bean.dart';
import 'package:flashinfo/search/model/autocomplete_bean.dart';

class BaseEntity<T> {
  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code] as int?;
    message = json[Constant.message] as String;
    if (json.containsKey(Constant.data)) {
      data = _generateOBJ<T>(json[Constant.data] as Object);
    }
  }

  int? code;
  late String message;
  T? data;

  T? _generateOBJ<O>(Object json) {
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else {
      /// List类型数据由fromJsonAsT判断处理
      // return JsonConvert.fromJsonAsT<T>(json);
      return _fromJsonAsT(json);
    }
  }

  T? _fromJsonAsT(Object json) {
    switch (T) {
      case StatusModel:
        return StatusModel.fromJson(json as Map<String, dynamic>) as T;
      case UserInfoModel:
        return UserInfoModel.fromJson(json as Map<String, dynamic>) as T;
      case AreaCodeModel:
        return AreaCodeModel.fromJson(json as Map<String, dynamic>) as T;
      case CaptchaEmailModel:
        return CaptchaEmailModel.fromJson(json as Map<String, dynamic>) as T;
      case CaptchaImgModel:
        return CaptchaImgModel.fromJson(json as Map<String, dynamic>) as T;
      case CaptchaSmsModel:
        return CaptchaSmsModel.fromJson(json as Map<String, dynamic>) as T;
      case RecommendBean:
        return RecommendBean.fromJson(json as Map<String, dynamic>) as T;
      case NewsBean:
        return NewsBean.fromJson(json as Map<String, dynamic>) as T;
      case TagsBean:
        return TagsBean.fromJson(json as Map<String, dynamic>) as T;
      case TagsModel:
        return TagsModel.fromJson(json as Map<String, dynamic>) as T;
      case BrowsingBean:
        return BrowsingBean.fromJson(json as Map<String, dynamic>) as T;
      case ExportBean:
        return ExportBean.fromJson(json as Map<String, dynamic>) as T;
      case InitializeModel:
        return InitializeModel.fromJson(json as Map<String, dynamic>) as T;
      case AutocompleteBean:
        return AutocompleteBean.fromJson(json as Map<String, dynamic>) as T;
      case PeoplesBean:
        return PeoplesBean.fromJson(json as Map<String, dynamic>) as T;
      case ProductsBean:
        return ProductsBean.fromJson(json as Map<String, dynamic>) as T;
      case CollectsListBeam:
        return CollectsListBeam.fromJson(json as Map<String, dynamic>) as T;
      case PayMentsListBean:
        return PayMentsListBean.fromJson(json as Map<String, dynamic>) as T;
      case GoPayBean:
        return GoPayBean.fromJson(json as Map<String, dynamic>) as T;
      case CompanyDetailModel:
        return CompanyDetailModel.fromJson(json as Map<String, dynamic>) as T;
      case CompanySubsidiaryModel:
        return CompanySubsidiaryModel.fromJson(json as Map<String, dynamic>)
            as T;
      case CompanyBean:
        return CompanyBean.fromJson(json as Map<String, dynamic>) as T;
      case CompanyContactModel:
        return CompanyContactModel.fromJson(json as Map<String, dynamic>) as T;
      case AlbumsBean:
        return AlbumsBean.fromJson(json as Map<String, dynamic>) as T;
      case Comments:
        return Comments.fromJson(json as Map<String, dynamic>) as T;
      case FinanceRoundsBean:
        return FinanceRoundsBean.fromJson(json as Map<String, dynamic>) as T;
      case InvestorsBean:
        return InvestorsBean.fromJson(json as Map<String, dynamic>) as T;
      case InvestmentsBean:
        return InvestmentsBean.fromJson(json as Map<String, dynamic>) as T;
      case UnlockContactModel:
        return UnlockContactModel.fromJson(json as Map<String, dynamic>) as T;
      case ExportModel:
        return ExportModel.fromJson(json as Map<String, dynamic>) as T;
      case EducationsBean:
        return EducationsBean.fromJson(json as Map<String, dynamic>) as T;
      case HonorsBean:
        return HonorsBean.fromJson(json as Map<String, dynamic>) as T;
      case PersonalDetailsBean:
        return PersonalDetailsBean.fromJson(json as Map<String, dynamic>) as T;
      case WorksBean:
        return WorksBean.fromJson(json as Map<String, dynamic>) as T;
      case ProductsDetailsBean:
        return ProductsDetailsBean.fromJson(json as Map<String, dynamic>) as T;
      case PeopleUnlockBean:
        return PeopleUnlockBean.fromJson(json as Map<String, dynamic>) as T;
      case CommentModel:
        return CommentModel.fromJson(json as Map<String, dynamic>) as T;
      case GoProductsModel:
        return GoProductsModel.fromJson(json as Map<String, dynamic>) as T;
      case CaptchaNumsModel:
        return CaptchaNumsModel.fromJson(json as Map<String, dynamic>) as T;
      case VipData:
        return VipData.fromJson(json as Map<String, dynamic>) as T;
      case HotWordsModel:
        return HotWordsModel.fromJson(json as Map<String, dynamic>) as T;
      case StaffLevel:
        return StaffLevel.fromJson(json as Map<String, dynamic>) as T;
      case BrandBean:
        return BrandBean.fromJson(json as Map<String, dynamic>) as T;
      case Events:
        return Events.fromJson(json as Map<String, dynamic>) as T;
      case BrandListBean:
        return BrandListBean.fromJson(json as Map<String, dynamic>) as T;
      case CompanyDetailsBean:
        return CompanyDetailsBean.fromJson(json as Map<String, dynamic>) as T;
      case Branches:
        return Branches.fromJson(json as Map<String, dynamic>) as T;
      case BusinessDatas:
        return BusinessDatas.fromJson(json as Map<String, dynamic>) as T;
      case Officers:
        return Officers.fromJson(json as Map<String, dynamic>) as T;
      case Reviews:
        return Reviews.fromJson(json as Map<String, dynamic>) as T;
      case ReviewsModel:
        return ReviewsModel.fromJson(json as Map<String, dynamic>) as T;
      case PeoplesNewBean:
        return PeoplesNewBean.fromJson(json as Map<String, dynamic>) as T;
      case ColleaguesBean:
        return ColleaguesBean.fromJson(json as Map<String, dynamic>) as T;
      case PersonWorkBean:
        return PersonWorkBean.fromJson(json as Map<String, dynamic>) as T;
      default:
    }
  }
}
