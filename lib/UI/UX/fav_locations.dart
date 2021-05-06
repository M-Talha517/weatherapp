import 'package:flutter/material.dart';
class Fav_City extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //get data from firebase
      itemCount: fav_cities_list_from_Firebase.length,
      itemBuilder: (context,index){
        return ListTile(
          title: fav_cities_list_from_Firebase[index].cityName,
          subtitle: fav_cities_list_from_Firebase[index].countryName,
          leading: IconButton(
            icon: Icon(Icons.add),
          ),
          trailing: IconButton(
            icon: Icon(Icons.menu),
          ),
        );
      }
    );
  }
}
