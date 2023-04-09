import 'package:covidttrackingapp/models/CountriesStatsModel.dart';
import 'package:covidttrackingapp/screens/detailcountry.dart';
import 'package:covidttrackingapp/services/StatsServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text("Countries List")),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(50)
                 ),
                  hintText: "Search country with name",
                  labelStyle: GoogleFonts.roboto(
                    fontSize: 10,
                  )

                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.fetchCountriesStatsRecord(),
                  builder: (context , AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                         return Shimmer.fromColors(
                             baseColor: Colors.black45,
                             highlightColor: Colors.black,
                         child: ListTile(
                           leading: Container(width: 89 , height: 10, color: Colors.black45),
                           title: Container(width: 89 , height: 10, color: Colors.black45),
                           subtitle: Container(width: 89 , height: 10, color: Colors.black45),
                         ));

                        });

                  }else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name  = snapshot.data![index]["country"].toString();
                          if(searchController.text.isEmpty){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                               DetailCountry(
                                   conName: snapshot.data![index]["country"].toString(),
                                   image: snapshot.data![index]["countryInfo"]["flag"].toString(),
                                   totalCases: snapshot.data![index]["cases"].toString(),
                                   totlaDeaths: snapshot.data![index]["deaths"].toString(),
                                   totalRecovered: snapshot.data![index]["recovered"].toString(),
                                   active: snapshot.data![index]["active"].toString(),
                                   critical: snapshot.data![index]["critical"].toString(),
                                   tests: snapshot.data![index]["tests"].toString())

                                ));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Image(
                                      width: 50,
                                      height: 50,
                                      image: NetworkImage(

                                        snapshot.data![index]["countryInfo"]["flag"]
                                            .toString(),
                                      ),
                                    ),
                                    title: Text(
                                      snapshot.data![index]["country"].toString(),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index]["cases"].toString(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    DetailCountry(
                                        conName: snapshot.data![index]["country"].toString(),
                                        image: snapshot.data![index]["countryInfo"]["flag"].toString(),
                                        totalCases: snapshot.data![index]["cases"].toString(),
                                        totlaDeaths: snapshot.data![index]["deaths"].toString(),
                                        totalRecovered: snapshot.data![index]["recovered"].toString(),
                                        active: snapshot.data![index]["active"].toString(),
                                        critical: snapshot.data![index]["critical"].toString(),
                                        tests: snapshot.data![index]["tests"].toString())));

                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Image(
                                      width: 50,
                                      height: 50,
                                      image: NetworkImage(

                                        snapshot.data![index]["countryInfo"]["flag"]
                                            .toString(),
                                      ),
                                    ),
                                    title: Text(
                                      snapshot.data![index]["country"].toString(),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index]["cases"].toString(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          else{
                            return Container();
                          }
                        });
                  }
              }),
            )
          ],
        ),
      ),
    );
  }
}
