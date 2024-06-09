// @dart=2.9

import 'package:authart_backoffice/Widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/Artist.dart';


class ArtistsPage extends StatefulWidget {
  //const ArtistsPage({Key? key}) : super(key: key);

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  List<Object> _ArtistsList = [];
  List<Object> _ArtistsListNotVerified = [];
  @override
  void didChangeDependencies() {
    getArtistsList();
  }

  Future getArtistsList() async {
    var alldata = await FirebaseFirestore.instance.collection('Artists').get();

    setState((){
      _ArtistsList = List.from(alldata.docs.map((doc) => Artist.fromSnapShot(doc)));
    });

    var data = await FirebaseFirestore.instance.collection('Artists_Demands').get();

    setState((){
      _ArtistsListNotVerified = List.from(data.docs.map((doc) => Artist.fromSnapShot(doc)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Header("Artists Details"),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("New Artists",
                    style: Theme.of(context).textTheme.subtitle1,),
                    SizedBox(
                      width: double.infinity,
                      child: DataTable(
                          columns: [
                            DataColumn(label: Text("Name")),
                            DataColumn(label: Text("Family Name")),
                            DataColumn(label: Text("email")),
                            DataColumn(label: Text("date")),
                            DataColumn(label: Text("speciality")),
                            DataColumn(label: Text("Diplome")),
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("")),


                          ],
                          rows: List.generate(
                              _ArtistsListNotVerified.length,
                                  (index) => ArtistDataRow(_ArtistsListNotVerified[index]),
                          )
                      ),
                    ),

                  ],
                ),
              ),
              /// All Artists Table
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Artists",
                      style: Theme.of(context).textTheme.subtitle1,),
                    SizedBox(
                      width: double.infinity,
                      child: DataTable(
                          columns: [
                            DataColumn(label: Text("Name")),
                            DataColumn(label: Text("Family Name")),
                            DataColumn(label: Text("email")),
                            DataColumn(label: Text("date")),
                            DataColumn(label: Text("speciality")),
                            DataColumn(label: Text("Diplome")),
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("")),
                          ],
                          rows: List.generate(
                            _ArtistsList.length,
                                (index) => ArtistDataRow(_ArtistsList[index]),
                          )
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
  DataRow ArtistDataRow(Artist artist){
    return DataRow(
        cells: [
          DataCell(Text(artist.Name)),
          DataCell(Text(artist.FName)),
          DataCell(Text(artist.Email)),
          DataCell(Text("02/06/2022")),
          DataCell(Text(artist.spec)),
          DataCell(Text(artist.dip)),
          DataCell(Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.remove_red_eye_outlined, color: Colors.white,)
            ),
          )),
          DataCell(Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.delete_outline, color: Colors.white,)
            ),
          ))
        ],
    );
  }
}
