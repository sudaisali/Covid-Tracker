import 'dart:convert';
import 'package:covidttrackingapp/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;
import '../models/WorldStatsModel.dart';
import '../models/CountriesStatsModel.dart';


class StatsServices{
  List<CountriesStatsModel> countriesList =[];
  Future<WorldStatsModel> fetchWorldStatsRecord() async{
    final response =await  http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode==200){
      var data = jsonDecode(response.body.toString());
      return WorldStatsModel.fromJson(data);
    }else{
        throw Exception('Error');
    }
    
  }
  Future<List<dynamic>> fetchCountriesStatsRecord() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200){
       data = jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception("Error");
    }


  }
}