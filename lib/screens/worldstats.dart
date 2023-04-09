import 'dart:async';

import 'package:covidttrackingapp/models/WorldStatsModel.dart';
import 'package:covidttrackingapp/screens/countrieslist.dart';
import 'package:covidttrackingapp/screens/splashscreen.dart';
import 'package:covidttrackingapp/services/StatsServices.dart';
import 'package:covidttrackingapp/widgets/reuseablerow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
 

  final colorList =[
   const  Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width*.01),
                  FutureBuilder(
                      future: statsServices.fetchWorldStatsRecord(),
                      builder: (context , AsyncSnapshot<WorldStatsModel>snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          )
                      );


                    }else {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: PieChart(
                                initialAngleInDegree: 0,
                                dataMap: {
                                  "Total": double.parse(snapshot.data!.cases.toString()),
                                  "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                  "Death": double.parse(snapshot.data!.recovered.toString()),
                                },
                                chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                  showChartValuesOutside: false
                                ),
                                chartType: ChartType.ring,
                                animationDuration: Duration(microseconds: 900),
                                chartRadius: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 3.2,
                                legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left,
                                ),
                                colorList: colorList,
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width*.05),
                          Column(
                            children: [
                              ReuseableRow(title: "Total", value: snapshot.data!.cases.toString()),
                              ReuseableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                              ReuseableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                              ReuseableRow(title: "Active", value: snapshot.data!.active.toString()),
                              ReuseableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                              ReuseableRow(title: "TodayDeaths", value: snapshot.data!.todayDeaths.toString()),
                              ReuseableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),


                            ],
                          ),

                        ],
                      );
                    }
                    }),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff1aa260)
                      ),
                      child: Center(child: Text("Track Countries",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,

                        ),)),
                    ),
                  )

                ],
              ),
            ),
          ),
        ));
  }
}

