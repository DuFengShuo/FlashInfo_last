import 'package:flashinfo/company/models/company_contact_model.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/models/company_subsidiary_model.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';

class CompanyProvider extends ChangeNotifier {
  CompanyDetailModel? _companyDetailModel;
  CompanyDetailModel? get companyDetailModel => _companyDetailModel;

  CompanySubsidiaryModel? _companySubsidiaryModel;
  CompanySubsidiaryModel? get companySubsidiaryModel => _companySubsidiaryModel;

  CompanyContactModel? _companyContactModel;
  CompanyContactModel? get companyContactModel => _companyContactModel;

  CompanyDetailsBean? _companyDetailsBean;
  CompanyDetailsBean? get companyDetailsBean => _companyDetailsBean;

  StateType _stateType = StateType.company;
  StateType get stateType => _stateType;

  void setStateType(StateType stateType) {
    _stateType = stateType;
    notifyListeners();
  }

  void setCompanyDetailBean(CompanyDetailsBean companyDetailsBean) {
    _companyDetailsBean = companyDetailsBean;
    notifyListeners();
  }

  void setCompanyDetailModel(CompanyDetailModel companyDetailModel) {
    _companyDetailModel = companyDetailModel;
    notifyListeners();
  }

  void setCompanySubsidiaryModel(
      CompanySubsidiaryModel companySubsidiaryModel) {
    _companySubsidiaryModel = companySubsidiaryModel;
    notifyListeners();
  }

  void setCompanyContactModel(CompanyContactModel companyContactModel) {
    _companyContactModel = companyContactModel;
    notifyListeners();
  }
}
