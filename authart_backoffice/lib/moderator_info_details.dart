import 'package:flutter/material.dart';

import 'models/Moderator.dart';


class ModeratorsInfoDetail extends StatelessWidget {


  final Moderator info;

  const ModeratorsInfoDetail({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border : Border.all(
            color: Colors.grey.shade50,
            width: 1),
        borderRadius: BorderRadius.circular(16),
        shape: BoxShape.rectangle,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              info.imagePath,
              width: 100,
              height: 100,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${info.Name} ${info.fName}",
                    style: TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.w600
                    ),
                  ),

                  Text(
                    "15/06/2022",
                    style: TextStyle(
                      color: Color(0xff7589a2).withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Icon(Icons.more_vert_rounded,color: Color(0xff7589a2).withOpacity(0.5),size: 18,)
        ],
      ),
    );
  }
}