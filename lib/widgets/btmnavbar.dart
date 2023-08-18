import 'package:flutter/material.dart';

class BottomNavigationBarcustom extends StatefulWidget {
  BottomNavigationBarcustom({Key? key}) : super(key: key);

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
            child: ListBody(
              children: <Widget>[
                Text('Clicked the $msg button.'),
                Text('You can add more content here.'),
              ],
            ),
          ),
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
              _onMenu(context, "List's");
            },
            icon: Icon(
              Icons.list_alt,
              color: Colors.white,
            ),
          ),
          // SizedBox(
          //   width: 20,
          // ),
          IconButton(
            padding: EdgeInsets.all(20.0),
            onPressed: () {
              _onMenu(context, 'Sort by');
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
              _onMenu(context, 'Add Task');
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
