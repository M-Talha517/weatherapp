import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weatherapp/Models/cities.dart';
import 'package:weatherapp/Models/forecasts.dart';


final apikey = ['HiSLpOOIq8oZuDpncGXJjZ1EaSPrRxT8','Ka6dkhmS3sZxIaPKBzxblceZVAiQy5GB'];

Future getListOfCities() async{ 
  final response = await http.post(
    Uri.parse('http://dataservice.accuweather.com/locations/v1/topcities/150?apikey=${apikey[1]}'),
    headers: {}
  );
  List listOfJsonData = jsonDecode(response.body);
  List<City> data = listOfJsonData.map((item)=>cityFromJson(item)).toList();
  return data;
}

Future getHourlyForecast(String cityKey) async{
  final response = await http.post(
    Uri.parse('http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/$cityKey?apikey=${apikey[1]}'),
    headers: {}
  );
  List listOfJsonData = jsonDecode(response.body);
  List<HourlyForecast> data = listOfJsonData.map((item)=>hourlyForecastFromJson(item)).toList();
  return data;
  
}

Future getDailyForecast(String cityKey) async{
  final response = await http.post(
    Uri.parse('http://dataservice.accuweather.com/forecasts/v1/daily/5day/$cityKey?apikey=${apikey[1]}'),
    headers: {}
  );
  List listOfJsonData = jsonDecode(response.body)["DailyForecasts"];
  List<DailyForecast> data = listOfJsonData.map((item)=>dailyForecastFromJson(item)).toList();
  return data;
  
}