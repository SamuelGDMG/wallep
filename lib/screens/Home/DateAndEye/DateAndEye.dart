import 'package:finance/screens/Home/DateSelected/CarouselCalendar.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateAndEye extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    StateSystem stateSystem = Get.find();

    return Row(
      children: [
        Expanded(
          flex: 1,
            child: DateSelected()
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (){
                stateSystem.showMoney.value = !stateSystem.showMoney.value;
              },
              icon: Obx(() => Icon(stateSystem.showMoney.value ? Icons.remove_red_eye : Icons.visibility_off,
                color: Colors.white,
              )),
            )
          ],
        )
      ],
    );
  }
}
