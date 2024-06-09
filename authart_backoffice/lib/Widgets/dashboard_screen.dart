// @dart=2.9

import 'package:authart_backoffice/Widgets/pie_chart_balance.dart';
import 'package:authart_backoffice/Widgets/pie_info_card.dart';
import 'package:authart_backoffice/models/Info.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'bar_chart_revenue.dart';
import 'header.dart';
import 'line_chart_demands.dart';

class DashboardScreen extends StatelessWidget {
  //const DashboardScreen({Key? key}) : super(key: key);

  List ChartData = [
    Info("AD's revenue", 20, Color(0xFF8ac926 )),
    Info("Premium Subscription", 47, Color(0xFFffca3a)),
    Info("No Subscription", 52, Color(0xFFdb3a34)),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Header("Dashboard"),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                      child: Column(
                        children: [
                          GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 16),
                              itemBuilder: (context , index) => Container(
                                padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 15,),
                                    ChartInfo(ChartData[index]),
                                  ],
                                ),

                              ),
                              itemCount: ChartData.length,
                              shrinkWrap: true,
                          ),
                          SizedBox(height: 15,),
                          SizedBox(
                            width: 850,
                            height: 400,
                            child: Container(

                              child: BarChartRevenue(),

                            ),
                          ),
                        ],
                      ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      //height: 500,
                      decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(.10))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children : [
                                PieChartSample3(),
                              ],
                            ),
                          ),
                          SizedBox(height: 25,),
                          PieInfoCard("AD's revenue","60"," ",Color(0xFF3066be)),
                          SizedBox(height: 10,),
                          PieInfoCard("Premium  Subscription revenue","40"," ",Color(0xFFb4c5e4)),
                          SizedBox(height: 10,),
                          LineChartSample1(),
                          /*Text("Subscription Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children : [
                                PieChart(
                                  PieChartData(
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 70,
                                      startDegreeOffset: -90,
                                      sections: [
                                        PieChartSectionData(value: 15,
                                          color: Colors.redAccent,
                                          radius: 15,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(value: 37,
                                          color: Colors.yellow,
                                          radius: 18,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(value: 43,
                                          color: Colors.blue,
                                          radius: 20,
                                          showTitle: false,
                                        ),
                                      ]
                                  ),
                                ),
                                Positioned.fill(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 70,),
                                        Text("119", style:Theme.of(context).textTheme.headline4 ,),
                                        Text("User"),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30,),
                          PieInfoCard("Pro Subscription","20","15%",Colors.redAccent),
                          SizedBox(height: 15,),
                          PieInfoCard("Free Subscription","47","37%",Colors.yellowAccent),
                          SizedBox(height: 15,),
                          PieInfoCard("No Subscription","52","42%",Colors.blueAccent),
*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
class ChartInfo extends StatelessWidget {
  Info info;
  ChartInfo(this.info);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: Stack(
            children : [
              CircularPercentIndicator(
                  radius: 80,
                  lineWidth: 18,
                  percent: info.nb/100,
                  progressColor: info.color,
                  backgroundColor: Colors.grey.shade100,
                circularStrokeCap: CircularStrokeCap.round,
                center:Text(info.nb.toString(), style: TextStyle(color: Colors.grey, fontSize: 30),),

              ),
              /*PieChart(
                PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    startDegreeOffset: 90,
                    sections: [
                      PieChartSectionData(value: info.nb.toDouble(),
                        color: info.color,
                        radius: 15,
                        showTitle: false,
                      ),
                      PieChartSectionData(value: 100-info.nb.toDouble(),
                        color: Colors.grey.shade100,
                        radius: 15,
                        showTitle: false,
                      ),
                    ]
                ),
              ),
              Positioned.fill(
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Text(info.nb.toString(), style: TextStyle(color: Colors.grey, fontSize: 30),),
                    ],
                  )
              ),*/
            ],
          ),
        ),
        SizedBox(height: 12,),
        Text(info.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
      ],
    );
  }

}

