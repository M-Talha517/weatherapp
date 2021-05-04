
class City{  
  String cityName;
  String key;
  String countryName;
  // could add country id instead of country name
  City({this.cityName, this.countryName, this.key});
}

City cityFromJson(Map response){
  return City(
    cityName: response['EnglishName'], 
    key:response['Key'], 
    countryName: response['Country']['EnglishName'] 
  );
}



