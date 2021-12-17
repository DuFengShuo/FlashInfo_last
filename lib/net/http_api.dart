class HttpApi {
  ///配置
  static const String icons = 'icons'; // 获取icon
  //获取初始化信息
  static const String init = 'init.json';

  /// 登录、注册
  static const String mobileLogin = 'code/mobile/authorization'; // 手机验证码登录
  static const String emailLogin = 'code/email/authorization'; // 手机验证码登录
  static const String login = 'authorization'; // 登录
  static const String visitor = 'authorization/visitor'; // 游客登录
  static const String authorizationImei = 'authorization/imei'; // 游客模式
  static const String appleLogin = 'social/apple'; // 苹果登录
  static const String googleLogin = 'social/google'; // 谷歌登录
  static const String linkedinLogin = 'social/linkedin/authorization'; // 领英登录
  static const String register = 'authorization/register'; // 注册
  static const String emailRegister = 'authorization/email/register'; // 邮箱注册
  static const String refresh = 'authorization/refresh'; // 刷新Access Token
  static const String captchaImage = 'captcha/image'; // 图片验证码
  static const String captchaSms = 'captcha/sms'; // 发送短信
  static const String captchaEmail = 'captcha/email'; // 获取邮箱验证码
  static const String verificationCode = 'verification/code'; //检查验证码
  static const String renewPwd = 'user/renew/pwd'; // 修改密码
  static const String userInfo = 'authorization/current'; // 获取个人信息
  static const String renewAvatar = 'user/renew/avatar'; // 修改头像
  static const String userUpdate = 'user'; // 修改个人信息
  static const String treatyTerms = '/treaty/terms.html'; // 用户协议
  static const String privacyPolicy = '/treaty/privacy_policy.html'; // 隐私协议
  static const String bindMobile = 'bind/mobile'; // 绑定手机号
  static const String bindEmail = 'bind/email'; // 绑定邮箱
  static const String captchaNums = 'captcha/nums'; // 根据当天验证码发送次数，判断是否需要弹出图形验证码

  static const String allBalance = 'balance?type=all'; //导出｜解锁余额

  static const String news = 'news'; // 新闻列表
  static const String recommends = 'recommends/company'; // 推荐公司列表

  static const String companyList = 'companys/v2'; // 公司列表
  static const String companySubsidiary = 'company/subsidiary'; // 公司详情其他数据
  static const String companyContact = 'company/contact'; // 获取公司联系方式
  static const String peopleContact = 'people/contact'; // 获取人员联系方式
  static const String similarCompany = 'similar/company'; // 获取人相似公司列表
  static const String personalList = 'peoples'; // 个人列表
  static const String commentIndex = 'comment/v2/index'; // 评论列表
  static const String commentStore = 'comment/store'; // 发表评论
  static const String companyFinanceRounds = 'company/finance/rounds'; // 公司融资记录
  static const String companyInvestors = 'company/investors'; //公司融资被投资者记录
  static const String companyInvestments = 'company/investments'; // 公司投资记录
  static const String companyStafflevel = 'company/stafflevel'; // 组织架构图

  /// 搜索
  static const String search = 'search/'; // 全局搜索
  static const String searchCompany = 'search/company/'; // 公司搜索
  static const String searchPeople = 'search/people/'; // 人员搜索
  static const String searchProduct = 'search/product/'; // 产品搜索
  static const String searchLead = 'search/lead/'; // 商机搜索
  static const String searchAutocomplete = 'search/'; // 搜索自动补全
  static const String searchBrands = 'search/brand/'; // 品牌搜索

  static const String productsList = 'products'; // 产品列表、详情

  ///收藏列表
  static const String collectsList = 'collects'; // 收藏列表
  ///标签列表
  static const String tagList = 'tags/'; // 标签列表

  ///编辑标签
  static const String tags = 'tags/';

  //添加公司或个人到标签
  static const String collect = 'collects/'; //收藏

  //添加公司或个人到标签
  static const String cancelCollect = 'collects/cancel/'; //取消收藏

  //设置
  static const String feedback = 'feedbacks'; //反馈
  static const String works = 'people/works'; //工作经验
  static const String educations = 'people/educations'; //教育
  static const String honors = 'people/honors'; //荣誉
  static const String historyRecord = 'history/record/'; //浏览记录
  static const String peoples = 'peoples'; //公司人员

  //热搜
  static const String hotWords = 'hot/words/random';

  static const String exportIndex = 'export/index'; //导出记录
  static const String export = 'export/store'; //导出

  //支付
  static const String payments = 'payments'; //支付
  static const String iosPay = 'ios/pay/return'; //ios支付
  static const String googlePay = 'google/product/return'; //google支付
  static const String googSubscriptionlePay =
      '/google/subscription/return'; //google订阅
  static const String paymentsGetproducts =
      'payments/getproducts'; //获取google、ios内购商品ID

  static const String companyAlbums = 'albums/company/index'; //导出
//解锁
  static const String peopleUnlock = 'people/unlock'; //解锁人员
  static const String peopleUnlockList = 'peoples/unlock/list'; //已解锁列表

//品牌详情
  static const String brandDetail = 'companys/v2'; // 品牌详情列表
  static const String brandPeople = 'brand/employees/list/'; //品牌人员
  static const String brandProduct = 'brand/products/list/'; //品牌产品
  static const String brandNews = 'brand/news/list/'; //品牌新闻
  static const String brandEvents = 'brand/events/list/'; //品牌事件
  static const String brandPhotos = 'brand/photos/list/'; //品牌相册
//最新公司详情
  static const String companyBranch = 'company/branch/list/'; // 公司分支列表
  static const String companyBusiness = 'company/business/list/'; // 公司品牌
  static const String companyOfficers = 'officer/list/'; // 董事会成员列表

//最新人员详情
  static const String peoplesDetail = 'peoples/'; //个人详情
  static const String peoplesCalleagues = 'people/colleagues/'; //人员详情同事
  static const String peoplesWorks = 'people/works/'; //人员详情工作经历
}
