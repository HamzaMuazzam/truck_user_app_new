import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/SubscriptionModel/subscription_plan.dart';
import 'package:sultan_cab/utils/const.dart';

import '/models/SubscriptionModel/subscription_plan.dart';

class SubscriptionPlan extends StatefulWidget {
  const SubscriptionPlan({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  @override
  void initState() {
    subscriptionProvider.getAllSubscriptionPlan();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subscription Plans",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Consumer<SubscriptionProvider>(
        builder: (_, value, __) {
          return value.subscriptionPlanModel != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: value.subscriptionPlanModel?.data?.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final Datum? datum = value.subscriptionPlanModel?.data?[index];

                      return subscriptionWidget(
                          datum: datum,
                          isActive: value.myActivePlanModel?.data?.id == datum?.id,
                          isAllowToBuy: value.myActivePlanModel?.data == null);
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
        },
      ),
    );
  }

  Widget subscriptionWidget({
    required Datum? datum,
    required bool isActive,
    required bool isAllowToBuy,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 10, spreadRadius: 1, color: Colors.grey.withOpacity(.2))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                datum?.planName ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Discount Price"),
                  SizedBox(width: 10),
                  Text(datum?.discountValue.toString() ?? ""),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(""),
                  SizedBox(width: 10),
                  if (datum?.createdAt != null)
                    Text(
                      timeString(datum!.createdAt!),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isActive
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 35,
                        )
                      : GestureDetector(
                          onTap: () async {
                            if (datum?.id != null) {
                              if (isAllowToBuy) {
                                subscriptionProvider.buyPlan(datum!.id!);
                              } else {
                                AppConst.errorSnackBar("You are already subscriber");
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Text(
                                "Buy",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String timeString(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}
