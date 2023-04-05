import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/providers/Dispute/dispute_provider.dart';
import 'package:sultan_cab/screens/Dispute/view_all_disputes.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';

class CreateDispute extends StatefulWidget {
  final int reqID;
  const CreateDispute({required this.reqID, Key? key}) : super(key: key);

  @override
  State<CreateDispute> createState() => _CreateDisputeState();
}

class _CreateDisputeState extends State<CreateDispute> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Dispute",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                "Create Dispute",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              AppTextField(
                validator: (v) {
                  if (v!.isEmpty) return "*required";

                  return null;
                },
                label: "Message:",
                controller: disputeProvider.createDisputeCtrl,
                suffix: null,
                isVisibilty: true,
              ),
              SizedBox(height: 20),
              AppButton(
                label: 'Create',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    bool result = await disputeProvider.createDispute(widget.reqID);

                    if (result) Get.to(AllDisputeList());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
