import 'package:another_project/model/artist.dart';
import 'package:another_project/utils/getArtistData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleListItem extends StatefulWidget {

  final Artist _artist;
  const CircleListItem(this._artist);

  @override
  State<CircleListItem> createState() => _CircleListItemState();
}

class _CircleListItemState extends State<CircleListItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //elevation: 8,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      //borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.blueAccent.shade100,width: 3),
          shape: BoxShape.circle,
          //borderRadius: BorderRadius.circular(28)
        ),
        child: InkWell(
          onTap: () { openDialog(); },

          child:Ink.image(
            image: NetworkImage(widget._artist.imagePath),
            //image : NetworkImage("https://firebasestorage.googleapis.com/v0/b/testproject-24792.appspot.com/o/LkklZtymwMZeqi3yFrjpeYYRWt32.jpg?alt=media&token=33e21dd0-6951-4b16-a5c9-c26b0c83cb75"),
            height: 90,
            width: 90,
            fit: BoxFit.cover,
          ),

        ),
      ),
    );

    /*
    return RaisedButton(
      onPressed: (){
        openDialog();
      },
      elevation: 0,
      color: Colors.white,
      child: SizedBox(
        width: 60,
        //height:60,
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                  aspectRatio: 4/3,
                  child: ClipOval(
                      //borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset('assets/images/user_image.jpg',fit: BoxFit.cover,height: 60,width: 60,),
                  )),
            ),
            const SizedBox(height: 4,),
            Text(
              widget._artist.Name,
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),
            ),

          ],
        ),
      ),
    );*/

  }

  /// Circle Image Widget ///
  Widget _buildCircleImage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        height: 75,
        width: 75,
        padding: EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          color: const Color(0xFF0E3311),
          border: Border.all(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.only(
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

  /// 2nd version of circle image ///
  Widget _buildCircleImage2() {
    return RaisedButton(
      onPressed: () {
        openDialog();
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
          borderRadius: BorderRadius.only(
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
                                builder: (context) => GetArtistProfile(artistName: widget._artist.Name,artistFName: widget._artist.FName,imagePath: widget._artist.imagePath,artistEmail: 'not found',),
                              ),
                            );
                          },
                          child: Row(
                            children: const [
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
}
