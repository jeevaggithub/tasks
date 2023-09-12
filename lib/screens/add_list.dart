import 'package:flutter/material.dart';
import 'package:tasks/auth/task_manager.dart';
// import 'package:tasks/screens/favorites.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  bool doneEnable = false;
  final addListFormKey = GlobalKey<FormState>();
  TextEditingController _listNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Material(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        'Create new list',
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                      SizedBox(
                        width: 100.0,
                      ),
                      TextButton(
                        onPressed: doneEnable
                            ? () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (addListFormKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  newTaskList(
                                      context, _listNameController.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              }
                            : null,
                        child: Text(
                          'Done',
                          style: TextStyle(
                              color: doneEnable ? Colors.blue : Colors.grey,
                              fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0.2,
                    color: Colors.white,
                  ),
                  Form(
                    key: addListFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: TextFormField(
                            controller: _listNameController,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              labelText: 'List name',
                              labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 58, 162, 247),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                doneEnable = value
                                    .trim()
                                    .isNotEmpty; // Set doneEnable based on input value
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                print(value);
                                return "Please Enter list name";
                              } else {
                                print(value);
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
