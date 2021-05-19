import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlaceReview {
  @required
   String reviewId;
  @required
   String reviewName;
  @required
   String reviewDate;
   String reviewText;
  String reviewRespond;
   String reviewPlaceId;


  PlaceReview(
      this.reviewId,
      this.reviewName,
      this.reviewDate, [
        this.reviewText,
        this.reviewRespond,
        this.reviewPlaceId,
      ]);


  factory PlaceReview.fromJson(Map<String, dynamic> json) {

    String _reviewId = json['reviewID'];
    String _reviewName = json['Name'];
    String _reviewDate = json['reviewDate'];
    String _reviewText = json['Review'];
    String _reviewRespond = json['Respond'];
    String _reviewPlaceId = json['placeID'];

    return new PlaceReview(_reviewId, _reviewName, _reviewDate, _reviewText, _reviewRespond, _reviewPlaceId);
  }


  Map<String, dynamic> toJson() => {
    'reviewID': reviewId,
    'Name': reviewName,
    'reviewDate': reviewDate,
    'Review': reviewText,
    'Respond': reviewRespond,
    'placeID': reviewPlaceId,
  };

}



Future<List<PlaceReview>> getAllReviews() async {
  final response = await http.get(
    Uri.http('uri', 'uri'),
  );

  if (response.statusCode == 200) {

    List<PlaceReview> model =(json.decode(response.body) as List).map((i) => PlaceReview.fromJson(i)).toList();

    return model;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> postReview(PlaceReview review) async {
  String json = jsonEncode(review);
  final response = await http.post(
    Uri.http('uri', 'uri'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json,
  );
}





