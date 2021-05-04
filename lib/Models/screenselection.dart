import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cities.dart';
import 'forecasts.dart';

class ScreenSelector with ChangeNotifier{
  bool isLoading = false;
  FullWeatherReport report = fwr;

  void setIsLoading(bool isLoading){
    this.isLoading = isLoading;
    notifyListeners();
  }
  
  void setReport(FullWeatherReport report){
    this.report = report;
    notifyListeners();
  }

}

HourlyForecast hour = HourlyForecast(temperature: '81',tempUnit: 'F',datetime:'5:50 AM',precipitationProbability: 2,iconphrase: 'Sunny',isDaylight: true,hourlyMobileLink: 'www',hasPrecipitation: true);
DailyForecast day = DailyForecast(dailyMobileLink:'www' ,maxTemp: '12',datetime: DateFormat('EEEE, d').format(convertToDate('2021-04-27T19:35:46+0000')) ,minTemp:'11');
FullWeatherReport fwr = FullWeatherReport(
  city: City(cityName: 'ISB', countryName: 'PAK', key: "123"),
  hourly: [hour,hour,hour,hour,hour,hour].sublist(1),
  daily: [day,day,day,day,day,day].sublist(1),
  );
List<City> cl = [City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123"),City(cityName: 'ISB', countryName: 'PAK', key: "123")];

