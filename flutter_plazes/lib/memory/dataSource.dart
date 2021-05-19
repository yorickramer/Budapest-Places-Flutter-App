import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_plazes/model/placeOpening.dart';
import 'package:flutter_plazes/model/placeModel.dart';
import 'package:flutter_plazes/model/placeReview.dart';
import 'package:http/http.dart' as http;

class dataSource {

  List<PlaceModel> places = new List<PlaceModel>();
  List<PlaceReview> reviews = new List<PlaceReview>();
  List<PlaceOpening> openings = new List<PlaceOpening>();

  dataSource()  {}

  Future<void> loadData() async {

    for(int i = 0; 30 > i; i++ ){
      PlaceModel place = new PlaceModel(i.toString(),"place"+i.toString(), "+36555555"+i.toString(),"placeFacebook" + i.toString(),"placeInstagram" + i.toString(),"placeEmail" + i.toString(),"placeWeb" + i.toString(),"Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.","Club","000000000000000000000000000000000000000",2,2,"placeAddress"  + i.toString(),"placeStatus");
      PlaceOpening opening =  new PlaceOpening("16:00","20:00","16:00", "20:00","16:00","20:00","16:00","20:00","16:00","20:00","Closed","Closed","Closed","Closed",i.toString());
      PlaceReview review =  new PlaceReview(i.toString(), "reviewName" + i.toString(), "reviewDate", "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.", "Thank you!",  "0");
      places.add(place);
      openings.add(opening);
      reviews.add(review);
    }
  }


  List<PlaceModel> getPlaces(){
    return places;
  }

  PlaceModel getPlacebyID(String id){
    for (var i = 0; i < places.length; i++) {
      if(id == places[i].placeId)
        return places[i];
    }
    return null;
  }

  PlaceOpening getOpeningbyPlaceID(String id){

    for (var i = 0; i < openings.length; i++) {
      if(id == openings[i].placeID)
        return openings[i];
    }
    return null;
  }

  List<PlaceReview> getReviewsbyPlaceID(String id){
    List<PlaceReview> _reviews = new List<PlaceReview>();
    for (var i = 0; i < reviews.length; i++) {
      if(id == reviews[i].reviewPlaceId)
        _reviews.add(reviews[i]);
    }
    return _reviews;
  }


  Future<void> setReview(PlaceReview _review) async {
    reviews.add(_review);
    //await postReview(_review);
  }

}