import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
          child: Column(
        children: [
          Text(
            '404',
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          )
        ],
      )),
    );
  }
}
