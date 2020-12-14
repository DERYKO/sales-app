import 'dart:convert';

import 'package:solutech_sat/api/dio_api.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class Api extends DioApi {
  Api(String apiUrl) : super(apiUrl);

  Future login(String email, String password) {
    return dio.post("/login", data: {
      "email": email,
      "password": password,
    });
  }

  Future startCloseDay(data) {
    return dio.post(
      "/startclose-day",
      data: data,
    );
  }

  Future getRoles() async {
    var userId = authManager.user?.id;
    return dio.get("/get-roles/$userId");
  }

  Future getRepSummary() async {
    var userId = authManager.user?.id;
    return dio.get("/get-summary", queryParameters: {
      "repid": "$userId",
    });
  }

  Future getAllocatedStockpoint() async {
    var userId = authManager.user?.id;
    return dio.get("/stockpoints/$userId");
  }

  Future getStockTakes(filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/stocktake", queryParameters: {
      "repid": authManager.user.id,
      "start": filterDates.first,
      "end": filterDates.last
    });
  }

  Future getMonthlyPerformance() async {
    return dio.get("/get-month-perfomance", queryParameters: {
      "repid": authManager.user.id,
    });
  }

  Future getPerformance(filterDates, year, period) async {
    return dio.get("/get-perfomance", queryParameters: {
      "userid": authManager.user.id,
    });
  }

  Future getPromotions() async {
    return dio.get("/promotions", queryParameters: {
      "userid": authManager.user.id,
    });
  }

  Future getToBankCheques() async {
    return dio.get("/tobank-cheques", queryParameters: {
      "userid": authManager.user.id,
    });
  }

  Future getCashToBank() async {
    return dio.get("/tobank-cash", queryParameters: {
      "userid": authManager.user.id,
    });
  }

  Future getCatlist(filterDates) async {
    return dio.get("/catlist", queryParameters: {
      "repid": authManager.user.id,
      "start": filterDates.first,
      "end": filterDates.last,
      "datee": filterDates.first,
    });
  }

  Future getSkusByCategory(String category, filterDates) async {
    return dio.get("/skubycategory", queryParameters: {
      "repid": authManager.user.id,
      "category": category,
      "start": filterDates.first,
      "end": filterDates.last,
      "datee": filterDates.first,
    });
  }

  Future getPosmMaterials() async {
    return dio.get("/list-posmmaterials");
  }

  Future getDeliveries() async {
    return dio.get("/get-deliveries");
  }

  Future getSurveys() async {
    return dio.get("/fetch-survey");
  }

  Future getSurveyAnswers(List<String> filterDates) async {
    return dio.get("/fetch-answers", queryParameters: {
      "repid": authManager.user.id,
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future getPriceLists() async {
    return dio.get("/pricelists", queryParameters: {
      "repid": authManager.user.id,
    });
  }

  Future getCustomerGroups() async {
    return dio.get("/customer-groups");
  }

  Future getAvailability(List<String> filterDates) async {
    return dio.get("/availabilitylist", queryParameters: {
      "repid": authManager.user.id,
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future getProductsAvailability(List<String> filterDates) async {
    return dio.get("/productsavailability", queryParameters: {
      "repid": authManager.user.id,
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future saveProductAudit(data) async {
    return dio.post("/save-availability", data: data);
  }

  Future savePosmAudit(data) async {
    return dio.post("/save-posmentries", data: data);
  }

  Future saveVisitSession(data) async {
    return dio.post("/startendvisit", data: data);
  }

  Future saveUpdatedSchedule(data) async {
    return dio.post("/update-schedule", data: data);
  }

  Future getOrders(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/orders", queryParameters: {
      "repid": "$userId",
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future getPosm(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/posmlist", queryParameters: {
      "repid": "$userId",
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future getProductUpdates(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/productupdates", queryParameters: {
      "repid": "$userId",
      "start": filterDates.first,
      "end": filterDates.last,
      "date": filterDates.first,
    });
  }

  Future getCompetitorActivities(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/competitoractivities", queryParameters: {
      "repid": "$userId",
      "start": filterDates.first,
      "end": filterDates.last,
      "date": filterDates.first,
    });
  }

  Future getSos(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get(
      "/list_sos",
      queryParameters: {
        "repid": "$userId",
        "start": filterDates.first,
        "end": filterDates.last
      },
    );
  }

  Future getSods(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get(
      "/get-sod",
      queryParameters: {
        "repid": "$userId",
        "start": filterDates.first,
        "end": filterDates.last
      },
    );
  }

  Future getGeneralPhotos(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get(
      "/get-photos",
      queryParameters: {
        "repid": "$userId",
        "start": filterDates.first,
        "end": filterDates.last
      },
    );
  }

  Future getTimesheets(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/get-checkins", queryParameters: {
      "repid": "$userId",
      "start": filterDates.first,
      "end": filterDates.last,
      "date": filterDates.first,
    });
  }

  Future saveBrandAudit(data) {
    return dio.post("/save-availability", data: data);
  }

  Future getVirtualStock() async {
    var userId = authManager.user?.id;
    return dio.get("/virtualstockbatch/$userId");
  }

  Future getStock(List<String> filterDates) async {
    return dio.get("/receivedgoods", queryParameters: {
      "repid": authManager.user?.id,
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future updateCustomer(data) async {
    return dio.post("/verifycustomer", data: data);
  }

  Future getStockPointStock() async {
    var userId = authManager.user?.id;
    return dio.get("/stockpointstocklevel/$userId");
  }

  Future getProducts() {
    return dio.get("/products");
  }

  Future getVirtualInventory() {
    return dio.get("/virtual-inventory");
  }

  Future getRecentPayments(tillNumber) {
    return dio.get("/payments", queryParameters: {
      "till_number": tillNumber,
    });
  }

  Future getUpdateProfile() async {
    return dio.post("/updateProfile", data: {
      "userid": "${authManager.user?.id}",
    });
  }

  Future getCommons() async {
    var userId = authManager.user?.id;
    return dio.get("/commondata/$userId");
  }

  Future getMustHaveSkus() async {
    return dio.get("/musthave-skus");
  }

  Future getPaymentModes() async {
    var userId = authManager.user?.id;
    return dio.get("/payment-modes", queryParameters: {
      "repid": userId,
    });
  }

  Future getPackagingOptions() {
    return dio.get("/packaging-options");
  }

  Future getMpesaPayments() async {
    var userId = authManager.user?.id;
    return dio.get("/get-mpesa-transactions", queryParameters: {
      "rep_id": userId,
    });
  }

  Future getPayments(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/list-payments", queryParameters: {
      "userid": userId,
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future getCustomerBalances() async {
    var userId = authManager.user?.id;
    return dio.get(
      "/get-customer-balances/$userId",
    );
  }

  Future getBrands() {
    return dio.get("/brands");
  }

  Future getBanks() {
    return dio.get("/list-banks");
  }

  Future getCategorySkus() {
    return dio.get("/category-skus");
  }

  Future addCustomer(customerData) async {
    return dio.post(
      "/add-customer",
      data: customerData,
    );
  }

  Future makeSale(sales) {
    return dio.post(
      "/sales",
      data: json.encode({
        "sales": sales,
      }),
    );
  }

  Future saveInventory(stock) {
    return dio.post(
      "/storevirtualstock",
      data: stock,
    );
  }

  Future addComment(data) {
    return dio.post(
      "/add-feedback-comments",
      data: data,
    );
  }

  Future saveSkipRecord(skipRecord) {
    return dio.post(
      "/saveskip",
      data: skipRecord,
    );
  }

  Future saveStockTake(stockTake) {
    return dio.post(
      "/save-stocktake",
      data: stockTake,
    );
  }

  Future saveOrder(sale) {
    return dio.post("/storesaleorder", data: sale);
  }

  Future saveBanking(banking) {
    return dio.post("/savebanking", data: banking);
  }

  Future savePrintedEtr(printedEtr) {
    return dio.post("/flag-printed", data: printedEtr);
  }

  Future savePaymentCollection(paymentCollection) {
    return dio.post("/collectpayment", data: paymentCollection);
  }

  Future saveStatusUpdate(stock) {
    return dio.post(
      "/save_updates",
      data: stock,
    );
  }

  Future saveFeedback(feedback) {
    return dio.post(
      "/add-general-feedback",
      data: feedback,
    );
  }

  Future getRoutePlans() async {
    var userId = authManager.user?.id;
    return dio.get("/route-plan/$userId");
  }

  Future getStockpointStockLevel() async {
    var userId = authManager.user?.id;
    return dio.get("/stockpointstocklevel/$userId");
  }

  Future getBankings(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/list-banking", queryParameters: {
      "userid": userId,
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future getStatusUpdates(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/repstatusupdates", queryParameters: {
      "userid": userId,
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future getFeedbacks(List<String> filterDates) async {
    var userId = authManager.user?.id;
    return dio.get("/get-feedback", queryParameters: {
      "repid": userId,
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future getSkipRecords(List<String> filterDates) {
    return dio.get("/unsuccesfullcalls", queryParameters: {
      "userid": authManager.user?.id,
      "start": filterDates.first,
      "end": filterDates.last,
    });
  }

  Future getCustomers() {
    return dio.get("/customers");
  }

  Future getFeedbackId(int feedbackId) {
    return dio.get("/feedback-comments/$feedbackId");
  }

  Future getModuleNames() {
    return dio.get("/modulenames");
  }

  Future getCloseDay() {
    return dio.get("/get-closeday", queryParameters: {
      "user_id": authManager.user.id,
    });
  }

  Future saveProductUpdate(data) {
    return dio.post(
      "/add-product-update",
      data: data,
    );
  }

  Future saveCompetitorActivity(data) {
    return dio.post(
      "/add-competitor-activity",
      data: data,
    );
  }

  Future saveSos(data) {
    return dio.post(
      "/save_sos",
      data: data,
    );
  }

  Future saveSod(data) {
    return dio.post(
      "/add-sod",
      data: data,
    );
  }

  Future saveGeneralPhoto(data) {
    return dio.post(
      "/add-photos",
      data: data,
    );
  }

  Future saveDelivery(data) {
    return dio.post(
      "/save-delivery",
      data: data,
    );
  }

  Future saveSurveyAnswers(data) {
    return dio.post(
      "/savesurvey-answers",
      data: data,
    );
  }

  Future getUserLocations() {
    return dio.get("/locations/${authManager.user?.id}");
  }

  Future getFeedbackCategories() {
    return dio.get("/feedback-categories");
  }

  Future sendLiveLocation(locationData) {
    return dio.post("/live-location", data: locationData);
  }
}

Api api = Api(config.apiUrl);
