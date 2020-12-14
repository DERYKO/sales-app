import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/bean/app_data_bean.dart';
import 'package:solutech_sat/data/bean/availability_bean.dart';
import 'package:solutech_sat/data/bean/availability_item_bean.dart';
import 'package:solutech_sat/data/bean/bank_bean.dart';
import 'package:solutech_sat/data/bean/banking_bean.dart';
import 'package:solutech_sat/data/bean/brand_bean.dart';
import 'package:solutech_sat/data/bean/cheque_bean.dart';
import 'package:solutech_sat/data/bean/collection_item_bean.dart';
import 'package:solutech_sat/data/bean/competitor_activity_bean.dart';
import 'package:solutech_sat/data/bean/csku_bean.dart';
import 'package:solutech_sat/data/bean/customer_balance_bean.dart';
import 'package:solutech_sat/data/bean/customer_group_bean.dart';
import 'package:solutech_sat/data/bean/delivery_bean.dart';
import 'package:solutech_sat/data/bean/delivery_order_detail_bean.dart';
import 'package:solutech_sat/data/bean/feedback_bean.dart';
import 'package:solutech_sat/data/bean/general_photo_bean.dart';
import 'package:solutech_sat/data/bean/initiative_free_bean.dart';
import 'package:solutech_sat/data/bean/initiative_qualify_bean.dart';
import 'package:solutech_sat/data/bean/inventory_bean.dart';
import 'package:solutech_sat/data/bean/module_name_bean.dart';
import 'package:solutech_sat/data/bean/must_have_sku_bean.dart';
import 'package:solutech_sat/data/bean/order_bean.dart';
import 'package:solutech_sat/data/bean/order_item_bean.dart';
import 'package:solutech_sat/data/bean/packaging_option_bean.dart';
import 'package:solutech_sat/data/bean/payment_bean.dart';
import 'package:solutech_sat/data/bean/payment_collection_bean.dart';
import 'package:solutech_sat/data/bean/payment_document_bean.dart';
import 'package:solutech_sat/data/bean/payment_mode_bean.dart';
import 'package:solutech_sat/data/bean/performance_bean.dart';
import 'package:solutech_sat/data/bean/photo_bean.dart';
import 'package:solutech_sat/data/bean/posm_bean.dart';
import 'package:solutech_sat/data/bean/posm_material_bean.dart';
import 'package:solutech_sat/data/bean/price_list_bean.dart';
import 'package:solutech_sat/data/bean/printed_etr_bean.dart';
import 'package:solutech_sat/data/bean/product_availability_detail_bean.dart';
import 'package:solutech_sat/data/bean/product_bean.dart';
import 'package:solutech_sat/data/bean/role_bean.dart';
import 'package:solutech_sat/data/bean/scheduled_delivery_bean.dart';
import 'package:solutech_sat/data/bean/session_bean.dart';
import 'package:solutech_sat/data/bean/shop_category_bean.dart';
import 'package:solutech_sat/data/bean/shop_route_bean.dart';
import 'package:solutech_sat/data/bean/skip_record_bean.dart';
import 'package:solutech_sat/data/bean/sod_bean.dart';
import 'package:solutech_sat/data/bean/sos_bean.dart';
import 'package:solutech_sat/data/bean/sos_item_bean.dart';
import 'package:solutech_sat/data/bean/status_update_bean.dart';
import 'package:solutech_sat/data/bean/stock_bean.dart';
import 'package:solutech_sat/data/bean/stock_item_bean.dart';
import 'package:solutech_sat/data/bean/stock_level_bean.dart';
import 'package:solutech_sat/data/bean/stock_take_bean.dart';
import 'package:solutech_sat/data/bean/stock_take_item_bean.dart';
import 'package:solutech_sat/data/bean/stockpoint_bean.dart';
import 'package:solutech_sat/data/bean/stockpoint_stock_level_bean.dart';
import 'package:solutech_sat/data/bean/survey_answer_bean.dart';
import 'package:solutech_sat/data/bean/survey_property_bean.dart';
import 'package:solutech_sat/data/bean/survey_question_bean.dart';
import 'package:solutech_sat/data/bean/timesheet_bean.dart';
import 'package:solutech_sat/data/bean/user_location_bean.dart';
import 'package:solutech_sat/data/bean/virtual_stock_bean.dart';
import 'package:solutech_sat/data/models/payment_document.dart';
import 'package:sqflite/sqflite.dart';

import 'bean/date_week_bean.dart';
import 'bean/feedback_category_bean.dart';
import 'bean/product_availability_bean.dart';
import 'bean/product_update_bean.dart';
import 'bean/promotion_bean.dart';
import 'bean/route_plan_bean.dart';
import 'bean/customer_bean.dart';

class Database {
  SqfliteAdapter _adapter;
  static Database INSTANCE;
  factory Database() => INSTANCE ??= new Database._instance();
  Database._instance();
  // Register beans
  ProductBean productBean;
  RoleBean roleBean;
  AppDataBean appDataBean;
  ShopCategoryBean shopCategoryBean;
  StockpointBean stockpointBean;
  InventoryBean inventoryBean;
  StockLevelBean stockLevelBean;
  StockpointStockLevelBean stockpointStockLevelBean;
  CustomerBean customerBean;
  RoutePlanBean routePlanBean;
  DateWeekBean dateWeekBean;
  VirtualStockBean virtualStockBean;
  StockBean stockBean;
  StockItemBean stockItemBean;
  OrderBean orderBean;
  OrderItemBean orderItemBean;
  UserLocationBean userLocationBean;
  SkipRecordBean skipRecordBean;
  StatusUpdateBean statusUpdateBean;
  FeedbackBean feedbackBean;
  BrandBean brandBean;
  PosmBean posmBean;
  PosmMaterialBean posmMaterialBean;
  AvailabilityBean availabilityBean;
  AvailabilityItemBean availabilityItemBean;
  SessionBean sessionBean;
  TimesheetBean timesheetBean;
  ProductAvailabilityBean productAvailabilityBean;
  ProductAvailabilityDetailBean productAvailabilityDetailBean;
  ProductUpdateBean productUpdateBean;
  CompetitorActivityBean competitorActivityBean;
  CskuBean cskuBean;
  SosBean sosBean;
  SosItemBean sosItemBean;
  SodBean sodBean;
  PhotoBean photoBean;
  GeneralPhotoBean generalPhotoBean;
  ScheduledDeliveryBean scheduledDeliveryBean;
  DeliveryBean deliveryBean;
  DeliveryOrderDetailBean deliveryOrderDetailBean;
  ShopRouteBean shopRouteBean;
  CustomerGroupBean customerGroupBean;
  PriceListBean priceListBean;
  PaymentModeBean paymentModeBean;
  CustomerBalanceBean customerBalanceBean;
  PackagingOptionBean packagingOptionBean;
  PaymentCollectionBean paymentCollectionBean;
  CollectionItemBean collectionItemBean;
  MustHaveSkuBean mustHaveSkuBean;
  SurveyPropertyBean surveyPropertyBean;
  SurveyQuestionBean surveyQuestionBean;
  SurveyAnswerBean surveyAnswerBean;
  PrintedEtrBean printedEtrBean;
  ModuleNameBean moduleNameBean;
  StockTakeBean stockTakeBean;
  StockTakeItemBean stockTakeItemBean;
  FeedbackCategoryBean feedbackCategoryBean;
  PromotionBean promotionBean;
  InitiativeQualifyBean initiativeQualifyBean;
  InitiativeFreeBean initiativeFreeBean;
  BankBean bankBean;
  ChequeBean chequeBean;
  BankingBean bankingBean;
  PaymentBean paymentBean;
  PaymentDocumentBean paymentDocumentBean;
  PerformanceBean performanceBean;

  Future init({bool createDbTables = false}) async {
    var dbPath = await getDatabasesPath();
    await Sqflite.setDebugModeOn(true);
    // Initialize sqlite adapter
    _adapter = SqfliteAdapter(
      path.join(dbPath, "${config.appDatabase}.db"),
      version: 4,
    );
    await _adapter.connect();
    _createBeans();
    if (await shouldCreateTables() || createDbTables) {
      print("Should create tables");
      createTables();
    }
  }

  // Initialize Bean
  void _createBeans() {
    productBean = ProductBean(_adapter);
    roleBean = RoleBean(_adapter);
    appDataBean = AppDataBean(_adapter);
    shopCategoryBean = ShopCategoryBean(_adapter);
    stockpointBean = StockpointBean(_adapter);
    inventoryBean = InventoryBean(_adapter);
    stockLevelBean = StockLevelBean(_adapter);
    stockpointStockLevelBean = StockpointStockLevelBean(_adapter);
    customerBean = CustomerBean(_adapter);
    routePlanBean = RoutePlanBean(_adapter);
    dateWeekBean = DateWeekBean(_adapter);
    virtualStockBean = VirtualStockBean(_adapter);
    stockBean = StockBean(_adapter);
    stockItemBean = StockItemBean(_adapter);
    orderBean = OrderBean(_adapter);
    orderItemBean = OrderItemBean(_adapter);
    userLocationBean = UserLocationBean(_adapter);
    skipRecordBean = SkipRecordBean(_adapter);
    statusUpdateBean = StatusUpdateBean(_adapter);
    feedbackBean = FeedbackBean(_adapter);
    brandBean = BrandBean(_adapter);
    posmBean = PosmBean(_adapter);
    posmMaterialBean = PosmMaterialBean(_adapter);
    availabilityBean = AvailabilityBean(_adapter);
    availabilityItemBean = AvailabilityItemBean(_adapter);
    sessionBean = SessionBean(_adapter);
    timesheetBean = TimesheetBean(_adapter);
    productAvailabilityBean = ProductAvailabilityBean(_adapter);
    productAvailabilityDetailBean = ProductAvailabilityDetailBean(_adapter);
    productUpdateBean = ProductUpdateBean(_adapter);
    competitorActivityBean = CompetitorActivityBean(_adapter);
    cskuBean = CskuBean(_adapter);
    sosBean = SosBean(_adapter);
    sosItemBean = SosItemBean(_adapter);
    sodBean = SodBean(_adapter);
    photoBean = PhotoBean(_adapter);
    generalPhotoBean = GeneralPhotoBean(_adapter);
    scheduledDeliveryBean = ScheduledDeliveryBean(_adapter);
    deliveryBean = DeliveryBean(_adapter);
    deliveryOrderDetailBean = DeliveryOrderDetailBean(_adapter);
    shopRouteBean = ShopRouteBean(_adapter);
    customerGroupBean = CustomerGroupBean(_adapter);
    priceListBean = PriceListBean(_adapter);
    paymentModeBean = PaymentModeBean(_adapter);
    customerBalanceBean = CustomerBalanceBean(_adapter);
    packagingOptionBean = PackagingOptionBean(_adapter);
    paymentCollectionBean = PaymentCollectionBean(_adapter);
    collectionItemBean = CollectionItemBean(_adapter);
    mustHaveSkuBean = MustHaveSkuBean(_adapter);
    surveyPropertyBean = SurveyPropertyBean(_adapter);
    surveyQuestionBean = SurveyQuestionBean(_adapter);
    surveyAnswerBean = SurveyAnswerBean(_adapter);
    printedEtrBean = PrintedEtrBean(_adapter);
    moduleNameBean = ModuleNameBean(_adapter);
    stockTakeBean = StockTakeBean(_adapter);
    stockTakeItemBean = StockTakeItemBean(_adapter);
    feedbackCategoryBean = FeedbackCategoryBean(_adapter);
    promotionBean = PromotionBean(_adapter);
    initiativeQualifyBean = InitiativeQualifyBean(_adapter);
    initiativeFreeBean = InitiativeFreeBean(_adapter);
    bankBean = BankBean(_adapter);
    chequeBean = ChequeBean(_adapter);
    bankingBean = BankingBean(_adapter);
    paymentBean = PaymentBean(_adapter);
    paymentDocumentBean = PaymentDocumentBean(_adapter);
    performanceBean = PerformanceBean(_adapter);
  }

  // Create tables
  void createTables() {
    productBean.createTable(
      ifNotExists: true,
    );
    roleBean.createTable(
      ifNotExists: true,
    );
    appDataBean.createTable(
      ifNotExists: true,
    );
    shopCategoryBean.createTable(
      ifNotExists: true,
    );
    stockpointBean.createTable(
      ifNotExists: true,
    );
    inventoryBean.createTable(
      ifNotExists: true,
    );
    stockLevelBean.createTable(
      ifNotExists: true,
    );
    stockpointStockLevelBean.createTable(
      ifNotExists: true,
    );
    routePlanBean.createTable(
      ifNotExists: true,
    );
    customerBean.createTable(
      ifNotExists: true,
    );
    dateWeekBean.createTable(
      ifNotExists: true,
    );
    virtualStockBean.createTable(
      ifNotExists: true,
    );
    stockBean.createTable(
      ifNotExists: true,
    );
    stockItemBean.createTable(
      ifNotExists: true,
    );
    orderBean.createTable(
      ifNotExists: true,
    );
    orderItemBean.createTable(
      ifNotExists: true,
    );
    userLocationBean.createTable(
      ifNotExists: true,
    );
    skipRecordBean.createTable(
      ifNotExists: true,
    );
    statusUpdateBean.createTable(
      ifNotExists: true,
    );
    feedbackBean.createTable(
      ifNotExists: true,
    );
    brandBean.createTable(
      ifNotExists: true,
    );
    posmBean.createTable(
      ifNotExists: true,
    );
    posmMaterialBean.createTable(
      ifNotExists: true,
    );
    availabilityBean.createTable(
      ifNotExists: true,
    );
    availabilityItemBean.createTable(
      ifNotExists: true,
    );
    sessionBean.createTable(
      ifNotExists: true,
    );
    timesheetBean.createTable(
      ifNotExists: true,
    );
    productAvailabilityBean.createTable(
      ifNotExists: true,
    );
    productAvailabilityDetailBean.createTable(
      ifNotExists: true,
    );
    productUpdateBean.createTable(
      ifNotExists: true,
    );
    competitorActivityBean.createTable(
      ifNotExists: true,
    );
    cskuBean.createTable(
      ifNotExists: true,
    );
    sosBean.createTable(
      ifNotExists: true,
    );
    sosItemBean.createTable(
      ifNotExists: true,
    );
    sodBean.createTable(
      ifNotExists: true,
    );
    photoBean.createTable(
      ifNotExists: true,
    );
    generalPhotoBean.createTable(
      ifNotExists: true,
    );
    scheduledDeliveryBean.createTable(
      ifNotExists: true,
    );
    deliveryBean.createTable(
      ifNotExists: true,
    );
    deliveryOrderDetailBean.createTable(
      ifNotExists: true,
    );
    shopRouteBean.createTable(
      ifNotExists: true,
    );
    customerGroupBean.createTable(
      ifNotExists: true,
    );
    priceListBean.createTable(
      ifNotExists: true,
    );
    paymentModeBean.createTable(
      ifNotExists: true,
    );
    customerBalanceBean.createTable(
      ifNotExists: true,
    );
    packagingOptionBean.createTable(
      ifNotExists: true,
    );
    paymentCollectionBean.createTable(
      ifNotExists: true,
    );
    collectionItemBean.createTable(
      ifNotExists: true,
    );
    mustHaveSkuBean.createTable(
      ifNotExists: true,
    );
    surveyPropertyBean.createTable(
      ifNotExists: true,
    );
    surveyQuestionBean.createTable(
      ifNotExists: true,
    );
    surveyAnswerBean.createTable(
      ifNotExists: true,
    );
    printedEtrBean.createTable(
      ifNotExists: true,
    );
    moduleNameBean.createTable(
      ifNotExists: true,
    );
    stockTakeBean.createTable(
      ifNotExists: true,
    );
    stockTakeItemBean.createTable(
      ifNotExists: true,
    );
    feedbackCategoryBean.createTable(
      ifNotExists: true,
    );
    promotionBean.createTable(
      ifNotExists: true,
    );
    initiativeQualifyBean.createTable(
      ifNotExists: true,
    );
    initiativeFreeBean.createTable(
      ifNotExists: true,
    );
    bankBean.createTable(
      ifNotExists: true,
    );
    chequeBean.createTable(
      ifNotExists: true,
    );
    bankingBean.createTable(
      ifNotExists: true,
    );
    paymentBean.createTable(
      ifNotExists: true,
    );
    paymentDocumentBean.createTable(
      ifNotExists: true,
    );
    performanceBean.createTable(
      ifNotExists: true,
    );
  }

  // Destroy database instance
  void destroy() {
    if (INSTANCE != null) {
      INSTANCE = null;
    }
  }

  // Drop and recreate tables
  void clearData() {
    if (INSTANCE != null) {
      createTables();
      productBean.drop();
      roleBean.drop();
      appDataBean.drop();
      shopCategoryBean.drop();
      stockpointBean.drop();
      inventoryBean.drop();
      stockLevelBean.drop();
      stockpointStockLevelBean.drop();
      routePlanBean.drop();
      customerBean.drop();
      dateWeekBean.drop();
      virtualStockBean.drop();
      stockBean.drop();
      stockItemBean.drop();
      orderBean.drop();
      orderItemBean.drop();
      userLocationBean.drop();
      skipRecordBean.drop();
      statusUpdateBean.drop();
      feedbackBean.drop();
      brandBean.drop();
      posmBean.drop();
      posmMaterialBean.drop();
      availabilityBean.drop();
      availabilityItemBean.drop();
      sessionBean.drop();
      timesheetBean.drop();
      productAvailabilityBean.drop();
      productAvailabilityDetailBean.drop();
      productUpdateBean.drop();
      competitorActivityBean.drop();
      cskuBean.drop();
      sosBean.drop();
      sosItemBean.drop();
      sodBean.drop();
      photoBean.drop();
      generalPhotoBean.drop();
      deliveryBean.drop();
      deliveryOrderDetailBean.drop();
      shopRouteBean.drop();
      customerGroupBean.drop();
      priceListBean.drop();
      paymentModeBean.drop();
      customerBalanceBean.drop();
      packagingOptionBean.drop();
      collectionItemBean.drop();
      mustHaveSkuBean.drop();
      surveyPropertyBean.drop();
      surveyQuestionBean.drop();
      surveyAnswerBean.drop();
      printedEtrBean.drop();
      moduleNameBean.drop();
      stockTakeBean.drop();
      stockTakeItemBean.drop();
      feedbackCategoryBean.drop();
      promotionBean.drop();
      initiativeQualifyBean.drop();
      initiativeFreeBean.drop();
      bankBean.drop();
      chequeBean.drop();
      bankingBean.drop();
      paymentBean.drop();
      paymentDocumentBean.drop();
      performanceBean.drop();
      createTables();
    }
  }

  // Check if tables should be created
  static Future<bool> shouldCreateTables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool shouldCreateTables = (prefs.getBool("should_create_tables") == null)
        ? true
        : prefs.getBool("should_create_tables");
    if (shouldCreateTables == true) {
      prefs.setBool("should_create_tables", false);
    }
    return shouldCreateTables;
  }
}

Database db = Database();
