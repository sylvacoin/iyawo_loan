import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  final String error;
  NotFoundPage({this.error});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(),
              Container(
                  child: Text(error ?? 'Not Found',
                      style: TextStyle(color: Colors.green, fontSize: 30)))
            ]),
      ),
    );
  }
}
