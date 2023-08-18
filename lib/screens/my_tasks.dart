import 'package:flutter/material.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({Key? key}) : super(key: key);

  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "MY TASKS works!",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
