import 'dart:math';

import 'package:brgyapp/services/authservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class AdminReportScreen extends StatefulWidget {
  @override
  _AdminReportScreenState createState() => _AdminReportScreenState();
}

class _AdminReportScreenState extends State<AdminReportScreen> {
  Color riskColorStatus = Colors.green;
  int overallUsers = 0;
  int userVaccinated = 0;
  int userNotVaccinated = 0;
  int userDryCough = 0;
  int userFever = 0;
  int userSoreThroat = 0;
  int userTiredness = 0;
  int totalRisk = 0;
  int averageRisk = 0;
  int numOfSinovac = 0;
  int numOfAstra = 0;
  int numOfPfizer = 0;
  int numOfModerna = 0;
  int numOfGamaleya = 0;
  int numOfNovavax = 0;

  @override
  void initState() {
    getAllUsers();
    getVaccinated();
    getNotVaccinated();
    getUserDryCough();
    getUserFever();
    getUserSoreThroat();
    getUserTiredness();
    addSinovacNumber();
    addAstraNumber();
    addGamaleyaNumber();
    addModernaNumber();
    addNovavaxNumber();
    addPfizerNumber();

    super.initState();
  }

  addSinovacNumber() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('prefferedVaccine', isEqualTo: 'Sinovac')
        .get();
    setState(() {
      numOfSinovac = snapshot.docs.length;
      print(numOfSinovac);
    });
  }

  addAstraNumber() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('prefferedVaccine', isEqualTo: 'AstraZenica')
        .get();
    setState(() {
      numOfAstra = snapshot.docs.length;
      print(numOfAstra);
    });
  }

  addPfizerNumber() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('prefferedVaccine', isEqualTo: 'Pfizer')
        .get();
    setState(() {
      numOfPfizer = snapshot.docs.length;
      print(numOfSinovac);
    });
  }

  addModernaNumber() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('prefferedVaccine', isEqualTo: 'Moderna')
        .get();
    setState(() {
      numOfModerna = snapshot.docs.length;
      print(numOfSinovac);
    });
  }

  addGamaleyaNumber() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('prefferedVaccine', isEqualTo: 'gamaleya')
        .get();
    setState(() {
      numOfGamaleya = snapshot.docs.length;
      print(numOfSinovac);
    });
  }

  addNovavaxNumber() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('prefferedVaccine', isEqualTo: 'Novavax')
        .get();
    setState(() {
      numOfNovavax = snapshot.docs.length;
      print(numOfSinovac);
    });
  }

  getUserDryCough() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('hasDryCough', isEqualTo: 'true')
        .get();
    setState(() {
      userDryCough = snapshot.docs.length;
      totalRisk = totalRisk + 5;
      print(userDryCough);
    });
  }

  getUserFever() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('hasFever', isEqualTo: 'true')
        .get();
    setState(() {
      userFever = snapshot.docs.length;
      totalRisk = totalRisk + 5;
      print(userFever);
    });
  }

  getUserSoreThroat() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('hasSoreThroat', isEqualTo: 'true')
        .get();
    setState(() {
      userSoreThroat = snapshot.docs.length;
      totalRisk = totalRisk + 5;
      print(userSoreThroat);
    });
  }

  getUserTiredness() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('hasTiredness', isEqualTo: 'true')
        .get();
    setState(() {
      userTiredness = snapshot.docs.length;
      totalRisk = totalRisk + 2;
      print(userTiredness);
    });
  }

  getVaccinated() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('isVaccinated', isEqualTo: 'yes')
        .get();
    setState(() {
      userVaccinated = snapshot.docs.length;
      totalRisk--;
      print(userVaccinated);
    });
  }

  getNotVaccinated() async {
    final QuerySnapshot snapshot = await usersRef
        .where('role', isEqualTo: 'resident')
        .where('isVaccinated', isEqualTo: 'no')
        .get();

    setState(() {
      userNotVaccinated = snapshot.docs.length;
      totalRisk = totalRisk + 2;
      print(userNotVaccinated);
    });
  }

  getAllUsers() async {
    final QuerySnapshot snapshot =
        await usersRef.where('role', isEqualTo: 'resident').get();
    setState(() {
      overallUsers = snapshot.docs.length;
      print(overallUsers);
    });
  }

  final spots = List.generate(100, (i) => (i - 50) / 10)
      .map((x) => FlSpot(x, sin(x)))
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3F5856),
      body: SingleChildScrollView(
        child: Column(
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
            Row(
              children: [
                RotatedBox(quarterTurns: 3, child: Text('Number of Cases')),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
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
                                  return touchedSpots
                                      .map((LineBarSpot touchedSpot) {
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
                                Colors.green,
                              ],
                              spots: [
                                FlSpot(0, 0),
                                FlSpot(overallUsers.toDouble(),
                                    userVaccinated.toDouble())
                              ], //y left x is right
                              isCurved: true,
                              isStrokeCapRound: true,
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                              dotData: FlDotData(show: true),
                            ),
                            LineChartBarData(
                              colors: [
                                Colors.red,
                              ],
                              spots: [
                                FlSpot(0, 0),
                                FlSpot(overallUsers.toDouble(),
                                    userNotVaccinated.toDouble())
                              ],
                              //y left x is right
                              isCurved: true,
                              isStrokeCapRound: true,
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                              dotData: FlDotData(show: true),
                            ),
                          ],
                          minY: 0,
                          maxY: overallUsers.toDouble(),
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
              ],
            ),
            Text('Number of Residents'),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text('Elements: ')),
            Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  color: Colors.green,
                ),
                Text(' Vaccinated ' + userVaccinated.toString()),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  color: Colors.red,
                ),
                Text(' Not Vaccinated ' + userNotVaccinated.toString()),
              ],
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
                              onPressed: () async {},
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
                      percent: totalRisk < 100 ? totalRisk / 100 : 100 / 100,
                      center: RotatedBox(
                          quarterTurns: 1,
                          child: Text(totalRisk.toString() + " %")),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor:
                          (totalRisk / 100) > 0.5 ? Colors.red : Colors.green,
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
                            BarChartRodData(y: numOfPfizer.toDouble(), colors: [
                              Colors.lightBlueAccent,
                              Colors.greenAccent
                            ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(y: numOfAstra.toDouble(), colors: [
                              Colors.lightBlueAccent,
                              Colors.greenAccent
                            ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                                y: numOfSinovac.toDouble(),
                                colors: [
                                  Colors.lightBlueAccent,
                                  Colors.greenAccent
                                ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                                y: numOfModerna.toDouble(),
                                colors: [
                                  Colors.lightBlueAccent,
                                  Colors.greenAccent
                                ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                                y: numOfGamaleya.toDouble(),
                                colors: [
                                  Colors.lightBlueAccent,
                                  Colors.greenAccent
                                ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 5,
                          barRods: [
                            BarChartRodData(
                                y: numOfNovavax.toDouble(),
                                colors: [
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
            Row(
              children: [
                Text(' Pfizer (Pf) ' + numOfPfizer.toString()),
              ],
            ),
            Row(
              children: [
                Text(' AstraZeneca (Az) ' + numOfAstra.toString()),
              ],
            ),
            Row(
              children: [
                Text(' Sinovac (Sv) ' + numOfSinovac.toString()),
              ],
            ),
            Row(
              children: [
                Text(' Moderna (Mn)' + numOfModerna.toString()),
              ],
            ),
            Row(
              children: [
                Text(' Gameleya (Gl) ' + numOfGamaleya.toString()),
              ],
            ),
            Row(
              children: [
                Text(' NovaVax (Nv) ' + numOfNovavax.toString()),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xffF5C69D),
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10)),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: GoogleFonts.spectral(
                        color: Color(0xff3F5856),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
