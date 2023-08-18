import 'package:flutter/material.dart';
import 'package:tasks/screens/add_list.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddList(), // Replace with your Favorites screen widget
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: const Color.fromARGB(255, 68, 169, 252),
                ),
              ),
            ),
            Text(
              'Create List',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
