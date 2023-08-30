import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String descrption;
  final String dueDate;
  const TaskCard(
      {required this.title,
      required this.descrption,
      required this.dueDate,
      Key? key})
      : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  widget.descrption,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.star_border_outlined,
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
