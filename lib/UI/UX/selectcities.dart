import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Models/cities.dart';
import 'package:weatherapp/Models/forecasts.dart';
import 'package:weatherapp/Models/screenselection.dart';
import 'package:weatherapp/Services/APIs.dart';
import 'package:weatherapp/Services/firebase.dart';

class SelectCity extends StatefulWidget {
  final citiesList;
  final void Function(int) ontap;
  SelectCity({this.citiesList, this.ontap});

  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  List<City> displayedcities = [];

  @override
  Widget build(BuildContext context) {
    ScreenSelector screenSelector = Provider.of<ScreenSelector>(context);
    Database db = Database();
    

    Future<void> loadData(int index,void Function(int) ontap) async {
      try {
        EasyLoading.show();

        print("Hourly");
        List<HourlyForecast> hourlyForecast= await getHourlyForecast(displayedcities[index].key);
        
        print("Daily");
        List<DailyForecast> dailyForecast= await getDailyForecast(displayedcities[index].key);
        
        FullWeatherReport report = FullWeatherReport(city: displayedcities[index], daily: dailyForecast.sublist(1), hourly: hourlyForecast.sublist(1) );
        screenSelector.setReport(report);
        EasyLoading.dismiss();
        print('dismissed loading');
        widget.ontap(1);
        db.addCity(displayedcities[index]);
      } catch (e) {
        EasyLoading.showError("FAILED TO FETCH DATA ONLINE");
        print("FAILED TO FETCH DATA ONLINE");
        print(e);
      }
    }
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: 
      SafeArea(
          child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter City Name',
                  fillColor: Colors.grey,
                ),
                onChanged: (val){
                  List<City> tobedisplayedcities = [];
                  widget.citiesList.forEach((item){
                    if (val!='' && item.cityName.toLowerCase().contains(val.toLowerCase()) &&  !tobedisplayedcities.contains(item)){
                      tobedisplayedcities.add(item);
                      }
                    }
                  );
                  setState(() {
                    displayedcities = tobedisplayedcities ;
                  });

                },
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: displayedcities.length,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 16.0),
                        child: Container(
                          color: Colors.transparent,
                          height: 2,
                          ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 16.0),
                        child: Card(
                            color: Colors.grey[200],
                            child: ListTile(
                            onTap: () async{
                              FullWeatherReport report;
                              screenSelector.setIsLoading(true);
                              FocusScope.of(context).unfocus();
                              try {
                                await loadData(index, widget.ontap);
                              }catch(e){
                                screenSelector.setReport(fwr);
                              }
                              
                              return report;         
                            },

                            focusColor: Colors.indigo.withOpacity(0.7),
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child:Text(displayedcities[index].cityName)
                            ), 
                            subtitle: Align(
                              alignment: Alignment.centerLeft,
                              child:Text(displayedcities[index].countryName)
                            ),
                                  
                          ),
                        )
                      ),
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      ),  
    );
  }
}
