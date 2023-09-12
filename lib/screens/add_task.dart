import 'package:flutter/material.dart';
import 'package:tasks/auth/task_manager.dart';
import 'package:date_field/date_field.dart';

class AddTask extends StatefulWidget {
  final String tasklistId;
  const AddTask({Key? key, required this.tasklistId}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String taskListId = '';
  bool doneEnable = false;
  final addTaskFormKey = GlobalKey<FormState>();
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  DateTime? _dueDate; // Store the selected due date

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
                        'Create new Task',
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                      SizedBox(
                        width: 98.0,
                      ),
                      TextButton(
                        onPressed: doneEnable
                            ? () {
                                if (addTaskFormKey.currentState!.validate()) {
                                  print('print from add task ,  ,');
                                  print(_taskNameController.text);
                                  print(_descController.text);
                                  print(_dueDate);
                                  print(widget.tasklistId);

                                  newTask(
                                      context,
                                      _taskNameController.text,
                                      widget.tasklistId,
                                      _descController.text,
                                      _dueDate);
                                  // If the form is valid, display a snackbar.
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //       content: Text('Processing Data')),
                                  // );
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
                    key: addTaskFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: TextFormField(
                            controller: _taskNameController,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              labelText: 'Task name',
                              labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 58, 162, 247),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                doneEnable = value.trim().isNotEmpty;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter task name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: TextFormField(
                            controller: _descController,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              labelText: 'Description',
                              labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 58, 162, 247),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                doneEnable = value.trim().isNotEmpty;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter description";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'My Super Date Time Field',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            firstDate:
                                DateTime.now().add(const Duration(days: 10)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 40)),
                            initialDate:
                                DateTime.now().add(const Duration(days: 20)),
                            autovalidateMode: AutovalidateMode.always,
                            validator: (DateTime? e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onDateSelected: (DateTime value) {
                              print(value);
                              _dueDate = value;
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
