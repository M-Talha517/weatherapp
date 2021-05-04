import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Models/cities.dart';
import 'package:weatherapp/Models/screenselection.dart';
import 'package:weatherapp/Models/forecasts.dart';
import 'package:weatherapp/Models/user.dart';
import 'package:weatherapp/Services/APIs.dart';
import 'package:weatherapp/Services/firebase.dart';
import 'package:weatherapp/UI/UX/wrapper.dart';
import 'Services/APIs.dart';
import 'UI/UX/selectcities.dart';
  
Color fontColor = Colors.white;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  List<City> citiesList;
  try{
    print('trying');
    citiesList = await getListOfCities();
  }catch(e){
    print('failed');
    citiesList = cl ;
  }
  runApp(
    ChangeNotifierProvider<ScreenSelector>.value(
      value: ScreenSelector(),
      child: MyApp(citiesList: citiesList),
    )
  );
}


class MyApp extends StatelessWidget {
  final citiesList ;
  MyApp({this.citiesList});

  @override
  Widget build(BuildContext context) {
    // ScreenSelector screenSelector = Provider.of<ScreenSelector>(context);

    return StreamProvider<CurrUser>.value(
      value: Authentication().currUser,
      initialData: null,
      child: MaterialApp(
        builder: EasyLoading.init(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: screenSelector.isLoading ? LoadingScreen() : screenSelector.report != null ? WeatherPage(screenSelector.report) : SelectCity(citiesList),  
        home: Wrapper(citiesList: citiesList),  
      ),
    );
  }
}




class WeatherPage extends StatefulWidget {
  final report ;
  final void Function(int) ontap;
  WeatherPage({this.ontap, this.report});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  
  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.location_city_rounded),         
          onPressed: (){
            widget.ontap(0);
          },
        ),
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children:[
              TextSpan(
                text: widget.report.city.cityName,
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                )
              ),
              TextSpan(
                text: ', ${widget.report.city.countryName}',
                style: TextStyle(
                  fontSize: 16,
                  color: fontColor,
                )
              )
            ] 
            ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(             
          image: DecorationImage(
            fit: BoxFit.fill,
            image: widget.report.hourly[0].isDaylight ? AssetImage('assets/day.jpg') : AssetImage('assets/night.jpg'),
        ),
      ),
       
        child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Center(
                        child: Text(
                          widget.report.hourly[0].temperature,
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: Center(
                        child: Text(
                          "${widget.report.daily[0].maxTemp} / ${widget.report.daily[0].minTemp}",
                          style: TextStyle(
                            
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Divider(
                thickness: 1,
                height: 20,
              ),
              LimitedBox(
              maxHeight: 120,
              child: ListView.builder(
                shrinkWrap: true,
                itemExtent: 75.0,
                scrollDirection: Axis.horizontal,
                itemCount: widget.report.hourly.length,
                itemBuilder: (context,index){
                  return Card(
                    color: Colors.transparent,
                    shadowColor: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "${widget.report.hourly[index].datetime}",
                            style: TextStyle(
                              color: fontColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold  
                            ),
                          ),
                        ),
                        Expanded(
                          child: widget.report.hourly[index].isDaylight ? Image.asset(
                            "assets/sun.png",
                            height: 25,
                            width: 25,
                            ): 
                            Image.asset(
                              "assets/moon.png",
                              height: 25,
                              width: 25,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.report.hourly[index].temperature,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,  
                            ),
                          ),
                        ),
                      ],
                    )
                    );
                  }
                ),
              ),
              
              Divider(
                thickness: 1,
                height: 20,
              ),

              Flexible(
                flex: 2,
                child: ListView.builder(
                  itemCount: widget.report.daily.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 16.0),
                          child: ListTile(
                            tileColor: Colors.white.withOpacity(0.35),
                            onTap: () async{
                              
                            },

                            focusColor: Colors.indigo.withOpacity(0.35),

                            title: Align(
                              alignment: Alignment.centerLeft,
                              child:Text(
                                '${widget.report.daily[index].datetime}',
                                style: TextStyle(
                                  color: fontColor,
                                ),
                              ),
                            ), 
                            subtitle: Align(
                              alignment: Alignment.centerLeft,
                              child:Text(
                                "${widget.report.daily[0].maxTemp} / ${widget.report.daily[0].minTemp}",
                                style: TextStyle(
                                  color: fontColor,
                                ),
                            ),
                          )
                        ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 16.0),
                          child: Divider(
                            height: 2,
                            thickness: 3,
                            color: Colors.grey.withOpacity(0.35),

                          ),
                        ),
                      ],
                    );
                  }
                  ),
              )
            ],
          ),
      ),
      );
    }
    
  }




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          
          backgroundColor: Colors.black87,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SpinKitCircle(
                        color: Colors.white,
                        size: 100.0,
                    )
                  ),
                  Text(
                    "LOADING PLEASE WAIT",
                    style: TextStyle(
                      color: Colors.white,
                  ),
                  ),
                ],
              ),
            ),
          ),
    );
   
    }
  }




class MyStatelessWidget extends StatelessWidget {
  final List<City> citiesList ;
  MyStatelessWidget(this.citiesList);

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController(initialPage: 1);

    void ontap(int index){
      try{
          _controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);        
      }
      catch(e){
        print(e);
        print('CONTROLLER FAILED');
      }
      
    }
    ScreenSelector screenSelector = Provider.of<ScreenSelector>(context);

    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      allowImplicitScrolling: true,
      scrollDirection: Axis.horizontal,
      controller: _controller,
      children: <Widget>[
        Center(
          child: SelectCity(citiesList: citiesList,ontap: ontap,),
        ),
        Center(
          child: WeatherPage(
            ontap: ontap, report: 
            screenSelector.report
          ),
        ),
      ],
    );
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





