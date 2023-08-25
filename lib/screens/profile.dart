import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/screens/login.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  // String userId = '12345'; // Provide a default value
  // String userName = 'john doe';
  // String userEmail = 'john@mail.com';
  // String userMobile = '1234567890';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userId = '';
  String userName = '';
  String userEmail = '';
  String userMobile = '';

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> _LogoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwtToken');
    prefs.remove('userId');
    prefs.remove('userName');
    prefs.remove('userEmail');
    prefs.remove('userMobile');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            LoginPage(), // Replace with your Favorites screen widget
      ),
    );
  }

  Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString('userId') ?? '';
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
      userMobile = prefs.getString('userMobile') ?? '';

      print('userId: pro $userId');
      print('userName: pro $userName');
      print('userEmail: pro $userEmail');
      print('userMobile: pro $userMobile');
    });
  }

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
              userName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              userEmail,
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 15.0),
            Text(
              userMobile,
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _LogoutUser();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.red), // Change this color
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
