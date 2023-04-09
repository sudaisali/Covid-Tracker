import 'package:flutter/material.dart';
import 'dart:async';
import 'package:covidttrackingapp/screens/worldstats.dart';

import 'package:google_fonts/google_fonts.dart';

import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorldStats()));
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Image(image: AssetImage("assets/virus.png"),),
                  ),
                ),
                builder: (BuildContext context , Widget? child){
                  return Transform.rotate(
                    angle: _controller.value * 2.0 *math.pi,
                    child: child,
                  );
                }),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
             Align(
              alignment: Alignment.center,
              child: Text("Covid19\nTrackerApp",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontWeight:FontWeight.w900,
                  fontSize:25,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
