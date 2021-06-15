import 'package:finance/state/StateSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SummaryChart extends StatelessWidget {

  final borderRadius = 16.0;

  final title = "2021";

  final labelChart;

  const SummaryChart({this.labelChart = ""});

  @override
  Widget build(BuildContext context) {

    StateSystem _stateSystem = Get.find();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(labelChart, style: TextStyle(
                  fontSize: 24
              ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Material(
            borderRadius: BorderRadius.circular(borderRadius),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Obx(() => SfCartesianChart(

                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<dynamic, dynamic>>[
                    LineSeries<dynamic, dynamic>(
                        dataSource: _stateSystem.dataSummaryChart[0],
                        xValueMapper: (data, _) => data["month"],
                        yValueMapper: (data, _) => data["total"],
                      isVisible: _stateSystem.showMoney.value
                    ),
                    LineSeries<dynamic, dynamic>(
                        dataSource: _stateSystem.dataSummaryChart[1],
                        xValueMapper: (data, _) => data["month"],
                        yValueMapper: (data, _) => data["total"],
                        isVisible: _stateSystem.showMoney.value
                    )
                  ],
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
