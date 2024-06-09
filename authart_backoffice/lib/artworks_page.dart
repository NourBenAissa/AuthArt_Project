// @dart=2.9

import 'package:authart_backoffice/Widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_compare/image_compare.dart';

import 'models/Artwork.dart';
import 'models/Artwork.dart';
import 'models/Artwork.dart';


class ArtworksPage extends StatefulWidget {
  //const ArtistsPage({Key? key}) : super(key: key);

  @override
  State<ArtworksPage> createState() => _ArtworksPageState();
}

class _ArtworksPageState extends State<ArtworksPage> {
  List<Object> _ArtworksList = [];
  List<Object> _ArtworksListNotVerified = [];
  List<String> _AllImages = ["https://firebasestorage.googleapis.com/v0/b/qr-art-eca6d.appspot.com/o/sky%20whale.jpg?alt=media&token=93952a3a-a14e-4a13-801d-1178b336f245"];
  Map<String,int> AllDiff = {};
  @override
  void didChangeDependencies() {
    getArtworksList();
    //GetAllDiff();
    SetDiff();
  }

  @override
  void initState() {
    SetDiff();
  }

  int diff=1;

  Future getArtworksList() async {
    var data = await FirebaseFirestore.instance.collection('Artworks_Demands').get();

    setState((){
      _ArtworksListNotVerified = List.from(data.docs.map((doc) => Artwork.fromSnapShot(doc)));
    });

    var alldata = await FirebaseFirestore.instance.collection('Artworks').get();

    setState((){
      _ArtworksList = List.from(alldata.docs.map((doc) => Artwork.fromSnapShot(doc)));
    });

    for(int i =2 ; i < _ArtworksList.length ;i++){
      Artwork arty = new Artwork();
      arty = _ArtworksList as Artwork;
      _AllImages.add(arty.imagePath);
    }
    print(_AllImages);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Header("Artworks "),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("New Artworks",
                      style: Theme.of(context).textTheme.subtitle1,),
                    SizedBox(
                      width: double.infinity,
                      child: DataTable(
                          columnSpacing: 30.0,
                          columns: [
                            DataColumn(label: Text("Image")),
                            DataColumn(label: Text("Uniqueness")),
                            DataColumn(label: Text("Creator")),
                            DataColumn(label: Text("Proprieties")),
                            DataColumn(label: Text("Type")),
                            DataColumn(label: Text("State")),
                            DataColumn(label: Text("Date of creation")),
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("")),


                          ],
                          rows: List.generate(
                            _ArtworksListNotVerified.length,
                                (index) => ArtworkDataRow(_ArtworksListNotVerified[index]),
                          )
                      ),
                    ),

                  ],
                ),
              ),
              /// All Artworks Table
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("All Artworks",
                      style: Theme.of(context).textTheme.subtitle1,),
                    SizedBox(
                      width: double.infinity,
                      child: DataTable(
                          columnSpacing: 30.0,
                          columns: [
                            DataColumn(label: Text("Image")),
                            DataColumn(label: Text("Uniqueness")),
                            DataColumn(label: Text("Creator")),
                            DataColumn(label: Text("Proprieties")),
                            DataColumn(label: Text("Type")),
                            DataColumn(label: Text("State")),
                            DataColumn(label: Text("Date of creation")),
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("")),


                          ],
                          rows: List.generate(
                            _ArtworksList.length,
                                (index) => ArtworkDataRow(_ArtworksList[index]),
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
  Future GetAllDiff()async{
    try {
      if (_ArtworksList != null) {
        for (int i = 1; i < _ArtworksList.length; i++) {
          Artwork artwork = new Artwork();
          artwork = (_ArtworksList[i] as Artwork);

          /// filling a list of images without the one that will be compared
          for (int i = 0; i < _ArtworksList.length; i++) {
            Artwork arty = new Artwork();
            arty = (_ArtworksList[i] as Artwork);
            if (artwork.imagePath != arty.imagePath) {
              _AllImages.add(arty.imagePath);
            }
          }

          /// ccomparing the image
          var networkResults = await listCompare(
            target: Uri.parse(artwork.imagePath),
            list: _AllImages,
            algorithm: AverageHash(),
          );
          int d = 1;

          /// calculating the results
          for (int j = 0; j < networkResults.length; j++) {
            if (networkResults[j].toInt() <= d) {
              d = networkResults[j].toInt();
            }
          }

          /// adding the result to the list
          AllDiff[artwork.Name] = d * 100;
        }
      } else {
        print(" No Data ");
      }
      print(AllDiff);
      setState(() {

      });
    }catch(e){

    }
  }
  Future SetDiff() async{
    try{
        Artwork art = new Artwork();
        art = _ArtworksList[0] as Artwork;

        /// ccomparing the image
        var networkResults = await listCompare(
          target: Uri.parse(art.imagePath),
          list: _AllImages,
          algorithm: AverageHash(),
        );

        int d = 1;

        /// calculating the results
        for (int j = 0; j < networkResults.length; j++) {
          if (networkResults[j].toInt() <= d) {
            d = networkResults[j].toInt();
          }
        }

        FirebaseFirestore.instance.collection('Artworks').doc(art.Name).update(
            {'Difference' : d*100 });

    }catch(e){
      print(e);
    }
  }

  DataRow ArtworkDataRow(Artwork artwork){

    return DataRow(
      cells: [
        DataCell(
            Container(
                height:300 ,
                width: 100,
                child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: FlatButton(
                        onPressed: (){},
                        padding: EdgeInsets.all(0.0),
                        child: Image.network(artwork.imagePath,))
                )
            )
        ),
        DataCell(Text("${AllDiff[artwork.Name]}")),
        DataCell(Text(artwork.creator)),
        DataCell(ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 100), //SET max width
            child:
            Text(" Height : "+artwork.height+" Width : "+artwork.weight+" Depth : "+artwork.depth+" Weight : "+artwork.weight, style: TextStyle(fontSize: 10,color: Colors.black54),)),

        ),
        DataCell(Text(artwork.type)),
        DataCell(Text(artwork.state)),
        DataCell(Text(artwork.date)),
        DataCell(
            Container(
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
            )
        ),
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
