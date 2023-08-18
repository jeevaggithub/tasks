import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future _showProfile(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Info'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is your profile.'),
                Text('You can add more content here.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2014/04/03/11/56/avatar-312603_1280.png',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              'john.doe@example.com',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
