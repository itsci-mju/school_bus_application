import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CardDetails extends StatelessWidget {
  final Color? cardColor;
  final double loadingPercent;
  final String title;
  final String? subtitle;
  final String number;

  CardDetails({
    this.cardColor,
    required this.loadingPercent,
    required this.title,
    this.subtitle,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(

        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(15.0),
        height: 130,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Text(
                  number,
                  style: const TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                /* Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                  ),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}