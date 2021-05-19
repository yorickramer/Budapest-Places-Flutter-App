import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_plazes/memory/dataSource.dart';
import 'package:flutter_plazes/memory/dataSource_provider.dart';
import 'package:flutter_plazes/model/placeModel.dart';
import 'package:flutter_plazes/screens/place_screen.dart';
import 'package:flutter_plazes/screens/plazes_list.dart';
import 'package:provider/provider.dart';

void main() {
  var data = dataSource();
  data.loadData().whenComplete(() => runApp(
    DataSourceProvider(
      data: data,
      child: MyApp(),
    ),
    //create: (BuildContext context) => DataSourceProvider(),
  )
  );


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "alma",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlaceList(
            placeList: DataSourceProvider.of(context).data.getPlaces(),
           )
    );
  }
}
//  place: DataSourceProvider.of(context).data.getPlacebyID("aeaa3589-e584-4f66-a2da-04fac7502339"), //7c93cfa8-cc8e-4ed9-af6b-1826f4236bb5
//             opening: DataSourceProvider.of(context).data.getOpeningbyPlaceID("aeaa3589-e584-4f66-a2da-04fac7502339"),
//             reviews : DataSourceProvider.of(context).data.getReviewsbyPlaceID("aeaa3589-e584-4f66-a2da-04fac7502339")//aeaa3589-e584-4f66-a2da-04fac7502339
//



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<PlaceModel> place;

  void _incrementCounter() {
    setState(() {
      _counter++;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        /*
        child: FutureBuilder<PlaceModel>(
            future: DataSourceProvider.of(context).data.loadData(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                return place_screen(snapshot.data);
              }
            }),

*/

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}