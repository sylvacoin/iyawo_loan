import 'package:flutter/material.dart';

class GCards extends StatefulWidget {
  final String title;
  final String body;
  final Color titleTextColor;
  final Color bodyTextColor;
  final Color cardBgColor;

  GCards({
    this.title,
    this.body,
    this.cardBgColor = Colors.pink,
    this.bodyTextColor = Colors.white,
    this.titleTextColor = Colors.white
  });

  @override
  _GCardsState createState() => _GCardsState();
}

class _GCardsState extends State<GCards> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            height: 100,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0x261f54c3),
                offset: Offset(0, 6),
                blurRadius: 20,
                spreadRadius: 4,
              ),
            ]),
            child: Card(
              color: widget.cardBgColor,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.title,
                          style: TextStyle(
                              color: widget.titleTextColor,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.body,
                          style: TextStyle(
                              color: widget.bodyTextColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0)),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
