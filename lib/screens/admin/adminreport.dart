import 'dart:math';

import 'package:brgyapp/services/authservices.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class AdminReportScreen extends StatefulWidget {
  @override
  _AdminReportScreenState createState() => _AdminReportScreenState();
}

class _AdminReportScreenState extends State<AdminReportScreen> {
  final spots = List.generate(101, (i) => (i - 50) / 10)
      .map((x) => FlSpot(x, sin(x)))
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3F5856),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(0, 30, 195, 0),
              child: Text(
                'Dashboard',
                style: GoogleFonts.spectral(
                    color: Color(0xffF5C69D),
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
            height: 200,
            width: 360,
            child: Padding(
              padding: const EdgeInsets.only(right: 22.0, bottom: 20),
              child: SizedBox(
                width: 400,
                height: 400,
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                          maxContentWidth: 100,
                          tooltipBgColor: Colors.orange,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((LineBarSpot touchedSpot) {
                              final textStyle = TextStyle(
                                color: touchedSpot.bar.colors[0],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              );
                              return LineTooltipItem(
                                  '${touchedSpot.x}, ${touchedSpot.y.toStringAsFixed(2)}',
                                  textStyle);
                            }).toList();
                          }),
                      handleBuiltInTouches: true,
                      getTouchLineStart: (data, index) => 0,
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        colors: [
                          Colors.black,
                        ],
                        spots: spots,
                        isCurved: true,
                        isStrokeCapRound: true,
                        barWidth: 3,
                        belowBarData: BarAreaData(
                          show: false,
                        ),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                    minY: -1.5,
                    maxY: 1.5,
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        margin: 16,
                      ),
                      rightTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        margin: 16,
                      ),
                      topTitles: SideTitles(showTitles: false),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: true,
                      horizontalInterval: 1.5,
                      verticalInterval: 5,
                      checkToShowHorizontalLine: (value) {
                        return value.toInt() == 0;
                      },
                      checkToShowVerticalLine: (value) {
                        return value.toInt() == 0;
                      },
                    ),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Risk Meter',
                          style: GoogleFonts.spectral(
                              color: Color(0xffF5C69D),
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      Text(
                          'Risk Factor would be the indicator if the brgy zone suggest into lock down. There are lot of factors that could be contribute in this indicator.',
                          style: GoogleFonts.spectral(
                              color: Color(0xffF5C69D),
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffF5C69D),
                                padding: EdgeInsets.fromLTRB(70, 10, 70, 10)),
                            onPressed: () async {
                              await context.read<AuthService>().signOut().then(
                                  (value) => Navigator.pushNamed(context, '/'));
                            },
                            child: Text(
                              'Declare Lockdown',
                              style: GoogleFonts.spectral(
                                  color: Color(0xff3F5856),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: 160,
                    animation: true,
                    lineHeight: 40.0,
                    animationDuration: 2500,
                    percent: 0.8,
                    center: RotatedBox(quarterTurns: 1, child: Text("80%")),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: AspectRatio(
              aspectRatio: 1.7,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: const Color(0xff3F5856),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                            color: Color(0xffF5C69D),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return 'Pf';
                            case 1:
                              return 'Az';
                            case 2:
                              return 'Sv';
                            case 3:
                              return 'Mn';
                            case 4:
                              return 'Gl';
                            case 5:
                              return 'Nv';
                            case 6:
                              return 'N/a';
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(y: 8, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(y: 10, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(y: 14, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(y: 15, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(y: 13, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(y: 10, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
