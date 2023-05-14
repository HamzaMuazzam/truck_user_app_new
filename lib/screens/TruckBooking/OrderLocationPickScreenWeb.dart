import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderLocationPickScreenWeb extends StatefulWidget {
  const OrderLocationPickScreenWeb({Key? key}) : super(key: key);

  @override
  State<OrderLocationPickScreenWeb> createState() =>
      _OrderLocationPickScreenWebState();
}

int _index = 0;

class _OrderLocationPickScreenWebState
    extends State<OrderLocationPickScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: Get.width,
          child: stepper(),
        )
      ],
    );
  }
}

Widget stepper() {

  List<EnhanceStep> tuples = [
    EnhanceStep( title: Text("Order Information"), content: Container(),icon: Icon(Icons.circle,size: 30,color: Colors.green,) ,state: StepState.complete),
    EnhanceStep( title: Text("Type of vehicle service"), content: Container(), icon: Icon(Icons.circle,size: 30)),
    EnhanceStep( title: Text("Request details"), content: Container(), icon: Icon(Icons.circle,size: 30)),
    EnhanceStep( title: Text("Delivered"), content: Container(), icon: Icon(Icons.circle,size: 30)),

  ];
  return
    EnhanceStepper(
        stepIconSize: 30,
        type: StepperType.horizontal,
        horizontalTitlePosition: HorizontalTitlePosition.inline,
        horizontalLinePosition: HorizontalLinePosition.top,
        currentStep: 2,

        physics: ClampingScrollPhysics(),
        steps: tuples,
        // steps: tuples.map((e) => EnhanceStep(
        //   icon: e.icon,
        //   state: StepState.values[tuples.indexOf(e)],
        //   isActive: _index == tuples.indexOf(e),
        //   title: e.title,
        //   subtitle: Text(""),
        //   content: Text(''),
        // )).toList(),
        onStepCancel: () {

        },
        onStepContinue: () {
        },
        onStepTapped: (index) {

        },

    );
}
