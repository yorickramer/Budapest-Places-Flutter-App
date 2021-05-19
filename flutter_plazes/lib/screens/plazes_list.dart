import 'package:flutter_plazes/model/placeModel.dart';
import 'package:flutter_plazes/screens/place_screen.dart';
import 'package:flutter_plazes/memory/dataSource_provider.dart';
import 'package:flutter_plazes/model/placeOpening.dart';
import 'package:flutter_plazes/model/placeReview.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatefulWidget {
  List<PlaceModel> placeList = new List();

  PlaceList({this.placeList});

  @override
  _PlaceListState createState() => _PlaceListState(placeList);
}

class _PlaceListState extends State<PlaceList> {
  List<PlaceModel> placeList = new List();
  List<PlaceModel> country = new List();

  _PlaceListState(this.placeList);

  @override
  void initState() {
    country.add(placeList[5]);
    country.add(placeList[10]);
    country.add(placeList[7]);
    country.add(placeList[8]);
    country.add(placeList[6]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a2b36),
      appBar: AppBar(
        backgroundColor: Color(0xff0c5985),
        title: Center(
            child: Text("Budapest Plazes")),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                "Hot Plazes",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 240,
                child: ListView.builder(
                    itemCount: country.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CountryListTile(
                        name: country[index].placeName,
                        status: country[index].placeStatus,
                        id: country[index].placeId,
                      );
                    }),
              ),

              Text(
                "All plazes",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: placeList.length,
                  itemBuilder: (context, index) {
                    return PopularTours(
                      id: placeList[index].placeId,
                      title: placeList[index].placeName,
                      status: placeList[index].placeStatus,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class PopularTours extends StatelessWidget {
  final String id;
  final String title;
  final String status;

  PopularTours(
      {@required this.id, @required this.status, @required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlaceScreen(
                    place: DataSourceProvider.of(context).data.getPlacebyID(id),
                    opening: DataSourceProvider.of(context)
                        .data
                        .getOpeningbyPlaceID(id),
                    reviews: DataSourceProvider.of(context)
                        .data
                        .getReviewsbyPlaceID(id))));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Image.network(
                  "https://i.pinimg.com/originals/48/78/6d/48786db88c95237f6e0b375dc991448a.png",
                  width: 100,
                  height: 100,
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "BambaBar",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    DataSourceProvider.of(context)
                        .data
                        .getOpeningbyPlaceID(id)
                        .openingToday(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountryListTile extends StatelessWidget {
  final String name;
  final String status;
  final String id;

  CountryListTile(
      {@required this.name, @required this.status, @required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlaceScreen(
                  place: DataSourceProvider.of(context).data.getPlacebyID(id),
                  opening: DataSourceProvider.of(context)
                      .data
                      .getOpeningbyPlaceID(id),
                  reviews: DataSourceProvider.of(context)
                      .data
                      .getReviewsbyPlaceID(id))));
    },child: Container(

      margin: EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 150,
            color: Colors.blueGrey,

            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 8, top: 8),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white38),
                        child: Text(
                          "Hot",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                ClipOval(
                    //borderRadius: BorderRadius.circular(3000),
                    child: Image.network(
                      "https://i.pinimg.com/originals/48/78/6d/48786db88c95237f6e0b375dc991448a.png",
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                    )),
                Row(
                  children: [

                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            status ?? "Open",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
