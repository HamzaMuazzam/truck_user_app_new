import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/SubscriptionModel/subscription_plan.dart';
import 'package:sultan_cab/models/SubscriptionPlan/get_all_plans.dart';
import 'package:sultan_cab/models/SubscriptionPlan/my_active_plan.dart';
import 'package:sultan_cab/services/ApiServices/api_services.dart';
import 'package:sultan_cab/services/ApiServices/api_urls.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'dart:convert';

import 'package:sultan_cab/utils/const.dart';

SubscriptionProvider subscriptionProvider = Provider.of<SubscriptionProvider>(Get.context!);

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionPlanModel? subscriptionPlanModel;

  void getAllSubscriptionPlan() async {
    String response = await ApiServices.getMethod(feedUrl: ApiUrls.GET_PLANS);

    if (response.isEmpty) return;
    subscriptionPlanModel = subscriptionPlanModelFromJson(response);
    await getActivatedPlan();
    notifyListeners();
  }

  Future<bool> buyPlan(int id) async {
    Map<String, String> fields = {"subscriptionId": "${id}"};

    String response = await ApiServices.postMethod(feedUrl: ApiUrls.BUY_PLAN, fields: fields);
    SubscriptionResponse subscriptionResponse = subscriptionResponseFromJson(response);

    if (response.isEmpty) {
      AppConst.errorSnackBar(subscriptionResponse.message ?? "");

      return false;
    }

    logger.i(response);
    AppConst.successSnackBar(subscriptionResponse.message ?? "");

    return true;
  }

  MyActivePlanModel? myActivePlanModel;
  Future<bool> getActivatedPlan() async {
    String response = await ApiServices.getMethod(feedUrl: ApiUrls.GET_ACTIVATED_PLAN);
    logger.i(response);
    if (response.isEmpty) return false;
    myActivePlanModel = myActivePlanFromJson(response);
    return true;
  }
}
