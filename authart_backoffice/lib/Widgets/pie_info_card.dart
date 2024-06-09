// @dart=2.9

import 'package:flutter/material.dart';

class PieInfoCard extends StatefulWidget {
  //const PieInfoCard({Key? key}) : super(key: key);
  String label,nb,perc;
  Color color;
  PieInfoCard(this.label, this.nb, this.perc,this.color);

  @override
  State<PieInfoCard> createState() => _PieInfoCardState();
}

class _PieInfoCardState extends State<PieInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 2,
            color: Colors.grey.withOpacity(0.15)),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            color: widget.color,
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.label, maxLines: 1,overflow: TextOverflow.ellipsis,),
                    Text(widget.nb, style : Theme.of(context).textTheme.caption,maxLines: 1,overflow: TextOverflow.ellipsis,)

                  ],
                ),
              )
          ),
          Text(widget.perc),
        ],
      ),
    );
  }
}
