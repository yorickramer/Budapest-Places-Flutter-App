import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlaceModel {
  @required
  final String placeId;
  @required
  final String placeName;
  @required
  final String placePhone;
  final String placeFacebook;
  final String placeInstagram;
  final String placeEmail;
  final String placeWeb;
  final String placeDescription;
  final String placeType;
  final String placeSubcategory;
  final double placeNumofPDF;
  final double placeNumofIMG;
  final String placeAddress;
  final String placeStatus;

  

  PlaceModel(
      this.placeId,
      this.placeName,
      this.placePhone, [
        this.placeFacebook,
        this.placeInstagram,
        this.placeEmail,
        this.placeWeb,
        this.placeDescription,
        this.placeType,
        this.placeSubcategory,
        this.placeNumofPDF,
        this.placeNumofIMG,
        this.placeAddress,
        this.placeStatus,
      ]);


  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    String _placeId = json['PlaceID'];
    String _placeName = json['PlaceName'];
    String _placePhone = json['PlacePhone'];
    String _placeFacebook = json['PlaceFacebook'];
    String _placeInstagram  = json['PlaceInstagram'];
    String _placeEmail = json['PlaceEmailAddress'];
    String _placeWeb = json['PlaceWebPage'];
    String _placeDescription = json['PlaceDescription'];
    String _placeType = json['PlaceType'];
    String _placeSubcategory = json['PlaceSubcategory'];
    double _placeNumofPDF = double.parse(json['numofPDF']);
    double _placeNumofIMG = double.parse(json['numofIMG']);
    String _placeAddress = json['PlaceAddress'];
    String _placeStatus = json['accepted'];
    return new PlaceModel(_placeId,_placeName, _placePhone,_placeFacebook,_placeInstagram,_placeEmail,_placeWeb,_placeDescription,_placeType,_placeSubcategory,_placeNumofPDF,_placeNumofIMG,_placeAddress,_placeStatus);
  }
}


Future<List<PlaceModel>> getAllPlaces() async {
  final response = await http.get(
    Uri.http("uri", "uri"),
  );

  if (response.statusCode == 200) {

     List<PlaceModel> model =(json.decode(response.body) as List).map((i) => PlaceModel.fromJson(i)).toList();

    return model;
  } else {
    throw Exception('Failed to load data');
  }
}


