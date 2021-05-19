import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PlaceOpening {

  final String mondayO;
  final String mondayC;
  final String tuesdayO;
  final String tuesdayC;
  final String wednesdayO;
  final String wednesdayC;
  final String thursdayO;
  final String thursdayC;
  final String fridayO;
  final String fridayC;
  final String saturdayO;
  final String saturdayC;
  final String sundayO;
  final String sundayC;
  final String placeID;


  PlaceOpening(this.mondayO,
      this.mondayC,
      this.tuesdayO,
      this.tuesdayC,
      this.wednesdayO,
      this.wednesdayC,
      this.thursdayO,
      this.thursdayC,
      this.fridayO,
      this.fridayC,
      this.saturdayO,
      this.saturdayC,
      this.sundayO,
      this.sundayC,
      this.placeID,);


  factory PlaceOpening.fromJson(Map<String, dynamic> json) {
    String _mondayO = json['MondayO'];
    String _mondayC = json['MondayC'];
    String _tuesdayO = json['TuesdayO'];
    String _tuesdayC = json['TuesdayC'];
    String _wednesdayO = json['WednesdayO'];
    String _wednesdayC = json['WednesdayC'];
    String _thursdayO = json['ThursdayO'];
    String _thursdayC = json['ThursdayC'];
    String _fridayO = json['FridayO'];
    String _fridayC = json['FridayC'];
    String _saturdayO = json['SaturdayO'];
    String _saturdayC = json['SaturdayC'];
    String _sundayO = json['SundayO'];
    String _sundayC = json['SundayC'];
    String _placeID = json['placeID'];

    return new PlaceOpening(_mondayO,_mondayC,_tuesdayO, _tuesdayC,_wednesdayO,_wednesdayC,_thursdayO,_thursdayC,_fridayO,_fridayC,_saturdayO,_saturdayC,_sundayO,_sundayC,_placeID);
  }
  String openingToday(){
    String day = DateFormat('EEEE').format(DateTime.now());
    switch (day) {
      case "Monday":
        return mondayO.trim() + " - " + mondayC.trim();
        break;
      case "Tuesday":
        return tuesdayO.trim() + " - " + tuesdayC.trim();
        break;
      case "Wednesday":
        return wednesdayO.trim() + " - " + wednesdayC.trim();
        break;
      case "Thursday":
        return thursdayO.trim() + " - " + thursdayC.trim();
        break;
      case "Friday":
        return fridayO.trim() + " - " + fridayC.trim();
        break;
      case "Saturday":
        return saturdayO.trim() + " - " + saturdayC.trim();
        break;
      case "Sunday":
        return sundayO.trim() + " - " + sundayC.trim();
        break;

    }
    return day;
  }
}






Future<List<PlaceOpening>> getAllOpenings() async {
  final response = await http.get(
    Uri.http('uri', 'uri'),
  );

  if (response.statusCode == 200) {

    List<PlaceOpening> model =(json.decode(response.body) as List).map((i) => PlaceOpening.fromJson(i)).toList();

    return model;
  } else {
    throw Exception('Failed to load data');
  }
}




