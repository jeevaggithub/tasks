import 'package:flutter/material.dart';
import 'package:tasks/auth/task_manager.dart';
import 'package:tasks/screens/add_list.dart';
// import 'package:tasks/screens/add_screen.dart';
import 'package:tasks/screens/add_task.dart';

class BottomNavigationBarcustom extends StatefulWidget {
  final void Function(String) onNavItemPressed; // Callback function
  final String currentTaskListId; // Add currentTaskListId

  BottomNavigationBarcustom({
    required this.onNavItemPressed,
    required this.currentTaskListId, // Initialize it in the constructor
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationBarcustom> createState() =>
      _BottomNavigationBarcustomState();
}

class _BottomNavigationBarcustomState extends State<BottomNavigationBarcustom> {
  var msg = '';

  Future<void> _onMenu(BuildContext context, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          content: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddList(), // Replace with your Favorites screen widget
                    ),
                  );
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    elevation: 12.0,
                    textStyle: const TextStyle(color: Colors.white)),
                child: const Text('Add Task List'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddTask(
                          tasklistId: widget
                              .currentTaskListId), // Replace with your Favorites screen widget
                    ),
                  );
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    elevation: 12.0,
                    textStyle: const TextStyle(color: Colors.white)),
                child: const Text('Add Tasks'),
              ),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _ondelete(BuildContext context, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          content: SingleChildScrollView(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  deleteTaskList(context, widget.currentTaskListId);
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    elevation: 12.0,
                    textStyle: const TextStyle(color: Colors.white)),
                child: const Text('yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    elevation: 12.0,
                    textStyle: const TextStyle(color: Colors.white)),
                child: const Text('No'),
              ),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _onOption(BuildContext context, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          content: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddList(), // Replace with your Favorites screen widget
                    ),
                  );
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 12.0,
                    textStyle: const TextStyle(color: Colors.white)),
                child: const Text(
                  'Add Task List',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _ondelete(
                      context, 'Are you sure want to delete this task list');
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 12.0,
                    textStyle: const TextStyle(color: Colors.white)),
                child: const Text(
                  'Delete Tasklist',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(137, 90, 90, 90),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.all(20.0),
            onPressed: () {
              print("printing from btm nav taskList _id:");
              print(widget.currentTaskListId);
              _onOption(context, 'Manage Tasklist');
              // if (widget.currentTaskListId != '') {
              //   _onOption(context, 'Manage Tasklist');
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //         content: Text('Only favorited task will show here'),
              //         backgroundColor: Colors.blueGrey),
              //   );
              // }
            },
            icon: Icon(
              Icons.list_rounded,
              color: Colors.white,
            ),
          ),
          // SizedBox(
          //   width: 20,
          // ),
          IconButton(
            padding: EdgeInsets.all(20.0),
            onPressed: () {
              // _onMenu(context, 'Sort by');
            },
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 190,
          ),
          IconButton(
            padding: EdgeInsets.all(10.0),
            color: const Color.fromARGB(255, 75, 169, 247),
            onPressed: () {
              print("printing from btm nav taskList _id:");
              print(widget.currentTaskListId);
              if (widget.currentTaskListId != '') {
                _onMenu(context, 'Add Task');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Only favorited task will show here'),
                      backgroundColor: Colors.blueGrey),
                );
              }
              // Call the callback function with currentTaskListId when the button is pressed
              // widget.onNavItemPressed(currentTaskListId);
            },
            icon: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 9, 142, 250),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.add,
                color: const Color.fromARGB(255, 125, 195, 253),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
