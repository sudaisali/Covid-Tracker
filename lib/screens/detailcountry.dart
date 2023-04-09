import 'package:covidttrackingapp/widgets/reuseablerow.dart';
import 'package:flutter/material.dart';

class DetailCountry extends StatefulWidget {
  final String? conName,image,totalCases,totlaDeaths,totalRecovered,active,critical,tests;
  const DetailCountry({Key? key,
  required this.conName,
  required this.image,
  required this.totalCases,
  required this.totlaDeaths,
  required this.totalRecovered,
  required this.active,
  required this.critical,
  required this.tests,
  }) : super(key: key);

  @override
  State<DetailCountry> createState() => _DetailCountryState();
}

class _DetailCountryState extends State<DetailCountry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text(widget.conName!)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height* .069),
                child: Card(
                    child: Column(
                      children: [
                         Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height* .06)),
                         ReuseableRow(title: "Cases" , value: widget.totalCases,),
                         ReuseableRow(title: "Recovered" , value: widget.totalRecovered,),
                         ReuseableRow(title: "Death" , value: widget.totlaDeaths,),
                         ReuseableRow(title: "Active" , value: widget.active,),
                         ReuseableRow(title: "Critical" , value: widget.critical,),
                         ReuseableRow(title: "Tests" , value: widget.tests,),
                      ],
                    )
                ),
              ),
              Positioned(child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.image!),

              )),

            ],
          )
        ],
      ),
    );
  }
}
