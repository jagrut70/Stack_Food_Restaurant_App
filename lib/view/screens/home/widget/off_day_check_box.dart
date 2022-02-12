import 'package:efood_multivendor_restaurant/controller/restaurant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffDayCheckBox extends StatelessWidget {
  final int weekDay;
  final RestaurantController restController;
  OffDayCheckBox({@required this.weekDay, @required this.restController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => restController.setWeekendString(weekDay.toString()),
        child: Row(children: [

          Checkbox(
            value: restController.weekendString.contains(weekDay.toString()),
            onChanged: (bool isActive) => restController.setWeekendString(weekDay.toString()),
            activeColor: Theme.of(context).primaryColor,
          ),

          Text(
            weekDay == 1 ? 'monday'.tr : weekDay == 2 ? 'tuesday'.tr : weekDay == 3 ? 'wednesday'.tr : weekDay == 4 ? 'thursday'.tr
                : weekDay == 5 ? 'friday'.tr : weekDay == 6 ? 'saturday'.tr : 'sunday'.tr,
          ),

        ]),
      ),
    );
  }
}
