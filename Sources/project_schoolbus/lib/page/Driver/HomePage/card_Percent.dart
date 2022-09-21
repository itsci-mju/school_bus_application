import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ActiveProjectsCard extends StatelessWidget {
  final Color? cardColor;
  final double? loadingPercent;
  final String title;
  final String? subtitle;
  final String seats;
  final String children;

  ActiveProjectsCard({
    this.cardColor,
    this.loadingPercent,
    required this.title,
    this.subtitle,
    required this.seats,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(

        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(15.0),
        height: 200,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 18),
              child: CircularPercentIndicator(
                animation: true,
                radius: 58.0,
                percent: ((double.parse(children)*100)/(int.parse(seats)))/100,
                lineWidth: 10.0,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white24,
                progressColor: Colors.white,
                center: Text(
                  '${children.toString()} / ${seats.toString()}',
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
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