import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';
import '../../tools/AppColors.dart';
import 'package:afsha/extensions/extension.dart';

class OrderStepper extends StatefulWidget {
  final ValueChanged<int> onChanged;
  @override
  _OrderStepperState createState() => _OrderStepperState();

  OrderStepper({ this.onChanged});
}

class _OrderStepperState extends State<OrderStepper> {
  // int selectedStep = 2;
  int nbSteps = 4;

  ValueNotifier<int> selectedStepNotifier = ValueNotifier<int>(1);
  TextStyle titleStyle_3 = TextStyle(
    color: AppColors.blackColor,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ValueListenableBuilder<int>(
      valueListenable: selectedStepNotifier,
      builder: (BuildContext context, int selectedStep, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "قيد التنفيذ",
                  style: titleStyle_3,
                ),
                Text(
                  "التغليف والتعبئة",
                  style: titleStyle_3,
                ),
                Text(
                  "الشحن",
                  style: titleStyle_3.copyWith(color: AppColors.grayDarkColor),
                ),
                Text(
                  "التوصيل",
                  style: titleStyle_3.copyWith(color: AppColors.grayDarkColor),
                ),
                // Text("")
              ],
            ).addPaddingOnly(bottom: 10),
            StepsIndicator(
              selectedStep: selectedStep,
              selectedStepWidget: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: AppColors.mainColor),
              ),
              unselectedStepWidget: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(color: AppColors.grayDarkColor)),
              ),
              doneStepWidget: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color:AppColors.mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Icon(
                  Icons.check,
                  size: 15,
                  color: Colors.white,
                ).setCenter(),
              ),
              nbSteps: nbSteps,
              doneLineColor: Color(0xffFAF2E8),
              doneStepColor: Colors.green,
              undoneLineColor: Color(0xffFAF2E8),
              lineLength: MediaQuery.of(context).size.width * .23,
              lineLengthCustomStep: [
                StepsIndicatorCustomLine(nbStep: 1, length: 105)
              ],
              enableLineAnimation: true,
              enableStepAnimation: true,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    if (selectedStep > 0) {
                      selectedStepNotifier.value--;
                      widget.onChanged(selectedStepNotifier.value);
                    }
                  },
                  child: const Text('Prev'),
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    if (selectedStep < nbSteps) {
                      selectedStepNotifier.value++;
                      widget.onChanged(selectedStepNotifier.value);
                    }
                  },
                  child: const Text('Next'),
                )
              ],
            )
          ],
        );
      },
    ));
  }
}
