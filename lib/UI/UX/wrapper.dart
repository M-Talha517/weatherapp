import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Models/cities.dart';
import 'package:weatherapp/Models/user.dart';
import 'package:weatherapp/main.dart';


class Wrapper extends StatelessWidget {
  final List<City> citiesList;

  const Wrapper({Key key, this.citiesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrUser currUser = Provider.of<CurrUser>(context);
    return currUser==null ? LoadingScreen(): MyStatelessWidget(citiesList);
    
  }
}