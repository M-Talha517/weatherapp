import 'package:intl/intl.dart';

import 'cities.dart';



class DailyForecast{
  String datetime;
  String maxTemp;
  String minTemp;
  String dailyMobileLink;
  DailyForecast({this.dailyMobileLink, this.maxTemp, this.minTemp, this.datetime});
}

DailyForecast dailyForecastFromJson(Map response){
  DateTime datetime = convertToDate(response["Date"]);
  String date = DateFormat('EEEE, d').format(datetime);
  
  return DailyForecast(
    datetime: date,
    dailyMobileLink: response["MobileLink"],
    maxTemp: response['Temperature']['Maximum']["Value"].toString(),
    minTemp: response['Temperature']['Minimum']["Value"].toString(),
    ); 
}

class HourlyForecast{
  
  String datetime;
  String iconphrase;
  String temperature;
  String tempUnit;
  bool hasPrecipitation;
  bool isDaylight;
  int precipitationProbability;
  String hourlyMobileLink;
  
  HourlyForecast({this.hasPrecipitation,this.iconphrase,this.isDaylight,this.hourlyMobileLink,this.precipitationProbability,this.tempUnit,this.temperature,this.datetime});
}

HourlyForecast hourlyForecastFromJson(Map response){
  DateTime fulldate = convertToDate(response["DateTime"]);
  String formattedDate = DateFormat.jm().format(fulldate);
  print(response["IsDaylight"]);
  print(formattedDate);
  return HourlyForecast(
    datetime: formattedDate,
    iconphrase: response["IconPhrase"],
    hasPrecipitation: response["HasPrecipitation"],
    hourlyMobileLink: response["MobileLink"],
    isDaylight: response["IsDaylight"],
    precipitationProbability: response["PrecipitationProbability"],
    temperature: response["Temperature"]["Value"].toString(),
  );
}

class FullWeatherReport{
  City city;
  List<HourlyForecast> hourly;
  List<DailyForecast> daily;
  
  FullWeatherReport({this.city, this.daily, this.hourly});
}

DateTime convertToDate(String datetime){
  return DateTime.parse(datetime);
}