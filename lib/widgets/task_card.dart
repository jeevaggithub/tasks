// import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:tasks/screens/task_screen.dart';

class TaskCard extends StatefulWidget {
  final String taskId;
  final String title;
  final String description;
  final String dueDate;
  const TaskCard(
      {required this.taskId,
      required this.title,
      required this.description,
      required this.dueDate,
      Key? key})
      : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.yellow,
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TaskScreen(
                  taskId: widget.taskId,
                  title: widget.title,
                  description: widget.description,
                  dueDate: widget
                      .dueDate), // Replace with your Favorites screen widget
            ),
          )
        },
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CheckboxExample(),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: 80,
                    color: Colors.grey,
                    child: Text(
                      widget.description,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  Text(
                    // Format the date and time here
                    // DateFormat('yyyy-MM-dd  HH:mm:ss')
                    //     .format(DateTime.parse(widget.dueDate)),
                    widget.dueDate,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  )
                ],
              ),
              Container(
                height: 0.25,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white, // Border color when unchecked
      ),
      child: Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0), // Circular border radius
          side: BorderSide(color: Colors.white), // Border color when checked
        ),
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}
