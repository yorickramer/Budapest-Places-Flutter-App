import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plazes/model/placeModel.dart';
import 'package:flutter_plazes/memory/dataSource_provider.dart';
import 'package:flutter_plazes/model/placeOpening.dart';
import 'package:flutter_plazes/model/placeReview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceScreen extends StatefulWidget {
  PlaceModel place;
  PlaceOpening opening;
  List<PlaceReview> reviews;

  PlaceScreen({this.place, this.opening, this.reviews});

  @override
  _PlaceScreenState createState() => _PlaceScreenState(place, opening, reviews);
}

class _PlaceScreenState extends State<PlaceScreen> {

  PlaceModel place;
  PlaceOpening opening;
  List<PlaceReview> reviews;


  _PlaceScreenState(this.place, this.opening, this.reviews);

  @override
  void initState() {
    //place = dataSource().getPlacebyID(id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a2b36), //082333,,  05344f
      appBar: AppBar(
        backgroundColor: Color(0xff0c5985),
        title: Center(child: Text(place == null ? "unknown" : place.placeName)),
      ),
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              ImageWidget("img", place.placeId, place.placeNumofIMG.toInt()),
              CustomCard(
                title: "Description",
                text: place.placeDescription == null
                    ? "unknown"
                    : place.placeDescription,
              ),
              CustomCard(
                title: "Today's openings",
                text: opening.openingToday(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    widget: Icon(FontAwesomeIcons.phone),
                    onTap: () {
                      launch(('tel://${place.placePhone}'));
                    },
                      width_: 50.0
                  ),
                  Button(
                    widget: Icon(FontAwesomeIcons.envelope),
                    onTap: () {
                      launch(('mailto://${place.placeEmail}'));
                    },
                      width_: 50.0
                  ),
                  Button(
                    widget: Icon(FontAwesomeIcons.facebook),
                    onTap: () {

                      if (canLaunch(place.placeFacebook) != null) {
                       launch(place.placeFacebook);
                      } else {
                      throw "no facebook provided";
                      }
                    },
                      width_: 50.0
                  ),
                  Button(
                    widget: Icon(FontAwesomeIcons.internetExplorer),
                    onTap: () {
                      if (canLaunch(place.placeWeb) != null) {
                        launch(place.placeWeb);
                      } else {
                        throw "no website provided";
                      }
                    },
                      width_: 50.0
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    widget: Text("More Info", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute(place, opening)),
                      );
                    },
                    width_: 100.0
                  ),
                  Button(
                    widget: Text("Reviews", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReviewScreen(place, reviews)),
                      );


                    },
                      width_: 100.0
                  ),
                ],
              ),
              Center(

                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(

                    "Price list",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              ImageWidget("pdf", place.placeId, place.placeNumofPDF.toInt()),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Widget widget;
  final Function onTap;
  double width_ = 50.0;

  Button({@required this.widget, @required this.onTap, this.width_});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color(0xff1175ad),
        elevation: 5.0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: SizedBox(
              width: width_,
              height: 50.0,
              child: Align(
                alignment: Alignment.center,
                  child: widget
              )
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String text, title;

  CustomCard({@required this.text, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff0c5985),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,

                ),
              ),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  List<Widget> images = [];
  String type;
  String guid;
  int cnt;
  int _height;

  ImageWidget(this.type,this.guid,this.cnt);

  addToList() {
    if(type == "img"){
      for(int i = 1; i <= cnt; i++){
        String imageUrl = "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHJlc3RhdXJhbnR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80";
        images.add(Image.network(imageUrl));
      }
      _height = 300;
    }
    else{
      for(int i = 1; i <= cnt; i++){
        String pdfUrl = "https://i.pinimg.com/originals/1c/a7/5e/1ca75e1020ffe2d57ca4f2c674f15151.jpg";
        images.add(Image.network(pdfUrl));
      }
      _height = 450;
    }
  }

  @override
  Widget build(BuildContext context) {
    addToList();
    print(images.length);
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: _height.toDouble()),
          items: images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //decoration: BoxDecoration(color: Colors.amber),
                  child: i,
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SecondRoute extends StatelessWidget {
  PlaceModel place;
  PlaceOpening opening;

  SecondRoute(this.place, this.opening);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a2b36),
      appBar: AppBar(
        backgroundColor: Color(0xff0c5985),
        title: Text("More Information"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [

              CustomCard(
                title: "Today Opening",
                text: place.placeDescription == null
                    ? "unknown"
                    : opening.openingToday(),
              ),
              CustomCard(
                title: "Phone Number",
                text: place.placePhone,
              ),
              CustomCard(
                title: "Email",
                text: place.placeEmail,
              ),
              CustomCard(
                title: "Address",
                text: place.placeAddress,
              ),
              CustomCard(
                title: "Instagram",
                text: place.placeInstagram,
              ),
              CustomCard(
                title: "WebPage",
                text: place.placeWeb,
              ),
              CustomCardOpening(opening),

            ],
          ),
        ),
      ),
    );
  }
}







class ReviewScreen extends StatelessWidget {
  PlaceModel place;
  List<PlaceReview> reviews;

  ReviewScreen(this.place, this.reviews);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a2b36),
      appBar: AppBar(
        backgroundColor: Color(0xff0c5985),
        title: Text("Reviews"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Button(
                    widget: Text("New review", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                    onTap: () {
                      _displayTextInputDialog(context, place.placeId);
                    },
                    width_: 50.0
                ),
              ),

              for(var review in reviews)
                CustomReviewCard(reviews == null ? new PlaceReview("321", "reviewName", "reviewDate", "text", "feri") : review ),


            ],
          ),
        ),
      ),
    );
  }
}



class CustomCardOpening extends StatelessWidget {
  final PlaceOpening opening;

  CustomCardOpening(this.opening);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff0c5985),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                "Opening during the week",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),
              ),
            ),
            Text(opening.mondayO + opening.mondayC),
            Text(opening.tuesdayO + opening.tuesdayC),
            Text(opening.wednesdayO + opening.wednesdayC),
            Text(opening.thursdayO + opening.thursdayC),
            Text(opening.fridayO + opening.fridayC),
            Text(opening.saturdayO + opening.saturdayC),
            Text(opening.sundayO + opening.sundayC),
          ],
        ),
      ),
    );
  }
}


class CustomReviewCard extends StatelessWidget {
  PlaceReview review;

  CustomReviewCard(this.review);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff0c5985),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(review.reviewName + " - " + review.reviewDate,
              style:TextStyle(
                color: Colors.white,
                fontSize: 25,
              ) ),
            Text(review.reviewText),
            Text(review.reviewRespond),
          ],
        ),
      ),
    );
  }
}

TextEditingController _textFieldController = TextEditingController();

Future<void> _displayTextInputDialog(BuildContext context, String placeID) async {

  PlaceReview review = PlaceReview(11.toString(), "reviewName", DateTime.now().toString());

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Write a review'),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: "Text Field in Dialog"),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              review.reviewText = _textFieldController.text;
              review.reviewPlaceId = placeID;
              review.reviewRespond = "";
              DataSourceProvider.of(context).data.reviews.add(review);
              //postReview(review);

              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}