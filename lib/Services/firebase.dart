import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weatherapp/Models/cities.dart';
import 'package:weatherapp/Models/user.dart';

class Authentication{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signintoFirebase() async{
    try{
      UserCredential uc = await _auth.signInAnonymously();
      User user = uc.user;
      return firebaseUserToCurrUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Stream<CurrUser> get currUser{
    while(true){
      try{
        print('signing in');
        signintoFirebase();
        return _auth.authStateChanges()
            .map(firebaseUserToCurrUser);
      }catch(e){
        print('failed');
        print(e.toString());        
      }
    }
  }

  CurrUser firebaseUserToCurrUser(User user){
    return CurrUser(user.uid);
  }
}


class Database{
  Future addCity(City city) async{
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    String uid = FirebaseAuth.instance.currentUser.uid;
    if (FirebaseAuth.instance.currentUser.uid != null){
      await user.doc(uid).collection('Cities').doc(city.cityName).set({
        "cityName": city.cityName, 
        "key" : city.key, 
        "countryName" : city.countryName, 
      });
    }
  }
}