import 'package:another_project/model/artist.dart';
import 'package:another_project/utils/getArtistData.dart';
import 'package:another_project/utils/getArtworkData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/artwork.dart';

class ArtworkListItem extends StatefulWidget {

  final Artwork _artwork;
  const ArtworkListItem(this._artwork);

  @override
  State<ArtworkListItem> createState() => _ArtworkListItemState();
}

class _ArtworkListItemState extends State<ArtworkListItem> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GetArtworkData(widget._artwork, false)),
        );
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 0, color: Colors.white),
      ),
      child: SizedBox(
        width: 190,
        //height:150,
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                  aspectRatio: 5/3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(widget._artwork.imagePath, fit: BoxFit.cover,)
                  )
              ),
            ),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text(
                  widget._artwork.Name,
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const SizedBox(height: 4,),
            _buildIcon(),

          ],
        ),
      ),
    );

  }
  /// Rectangle Image Widget ///
  Widget _buildRecImage() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          widget._artwork.imagePath,
          //'assets/images/test_artwork.png',
          height: 250,
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  Widget _buildText() {
    return Text(
      widget._artwork.Name,
      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal , fontSize: 18),
    );
  }
  Widget _buildArtistName() {
    return Text(
      'by Artist',
      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal ,fontSize: 18),
    );
  }
  Widget _buildIcon() {
    return Row(
      children: [
        Image.asset('assets/images/heart_icon.png',width: 15,height: 15,),
        Text(
          ' 20',
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }




  /// Circle Image Widget ///
  /*
  Widget _buildCircleImage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        height: 75,
        width: 75,
        padding: EdgeInsets.all(0.5),
        decoration: new BoxDecoration(
          color: const Color(0xFF0E3311),
          border: new Border.all(
            color: Colors.black54,
          ),
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
            bottomLeft: const Radius.circular(40.0),
            bottomRight: const Radius.circular(40.0),
          ),
        ),
        child: ClipOval(
          child: Image.asset("assets/images/avatar.png"),
          //clipper: openDialog(),
        ),
      ),
    );
  }
*/
  /// 2nd version of circle image ///

  Widget _buildCircleImage2() {
    return RaisedButton(
      onPressed: () {
        //openDialog();
      },
      color: Colors.white,
      elevation: 0,
      //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        height: 75,
        width: 75,
        padding: EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          color: const Color(0xFF0E3311),
          border: Border.all(
            color: Colors.black54,
          ),
          /*borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
            bottomLeft: const Radius.circular(40.0),
            bottomRight: const Radius.circular(40.0),
          ),

           */
        ),
        child: ClipRRect(
          child: Image.asset(widget._artwork.imagePath),
          //clipper: openDialog(),
        ),
      ),
    );
  }
/*
  Widget _buildText() {
    return Text(
      widget._artist.Name,
      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal ),
    );
  }

  Future openDialog() {
    return showDialog(
      context: context,
      builder: (context) =>

          Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    ClipOval(
                      child: Image.network(widget._artist.imagePath,fit: BoxFit.cover,width: 128, height: 128,),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      widget._artist.Name+" "+widget._artist.FName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blueAccent.shade100,
                      ),
                    ),
                    SizedBox(height: 45,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GetArtistProfile(artistName: widget._artist.Name,artistFName: widget._artist.FName,imagePath: widget._artist.imagePath,artistEmail: 'alela',),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text("See Profile "),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
  Widget buildImage() {
    //final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Image.network(widget._artist.imagePath,fit: BoxFit.cover,width: 128, height: 128,),
        //child: InkWell(onTap: onClicked),
      ),
    );
  }
  */
}
