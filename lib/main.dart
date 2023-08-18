import 'package:flutter/material.dart';
import 'package:tasks/screens/NotFoundScreen.dart';
// import 'package:tasks/screens/add_list.dart';
import 'package:tasks/screens/add_screen.dart';
import 'package:tasks/screens/favorites.dart';
import 'package:tasks/screens/login.dart';
import 'package:tasks/screens/my_tasks.dart';
import 'package:tasks/screens/profile.dart';
import 'package:tasks/screens/register.dart';
import 'package:tasks/widgets/btmnavbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: '/',
      // onGenerateRoute: generateRoute,
      home: RegisterPage(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onProfileClick(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Dialog'),
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

  int currentPageIndex = 0;

  final List<Widget> screens = [
    Favorites(),
    MyTasks(),
    AddScreen(),
    // OtherTaskScreen(),
    // Add more screens as needed
  ];

  final List<IndicatorData> indicators = [
    IndicatorData(widget: Icon(Icons.star), isIcon: true),
    IndicatorData(widget: Text('My Tasks'), isIcon: false),
    IndicatorData(widget: Text('Add List'), isIcon: false),
    // Add more indicator data as needed
  ];

  void _showUserProfilePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Profile();
      },
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/addlist':
        return MaterialPageRoute(builder: (_) => AddScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      // Define more routes as needed
      default:
        return MaterialPageRoute(builder: (_) => NotFoundScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tasks",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton.filled(
            padding: EdgeInsets.all(0.0),
            color: Colors.black,
            alignment: Alignment.center,
            onPressed: () {
              // _onProfileClick(context);
              _showUserProfilePopup(context);
            },
            icon: CircleAvatar(
              maxRadius: 15.0, minRadius: 15.0,

              backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2014/04/03/11/56/avatar-312603_1280.png',
              ), // Replace with your image asset
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Your custom indicator bar here
          Container(
            height: 50,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(indicators.length, (index) {
                final isActive = index == currentPageIndex;
                final indicatorData = indicators[index];

                if (indicatorData.isIcon) {
                  final icon = indicatorData.widget as Icon;
                  return GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(index);
                    },
                    child: Icon(
                      icon.icon,
                      color: isActive ? Colors.blue : Colors.white,
                    ),
                  );
                } else {
                  final text = indicatorData.widget as Text;
                  return GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(index);
                    },
                    child: Text(
                      text.data!,
                      style: TextStyle(
                        color: isActive ? Colors.blue : Colors.white,
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              children: screens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarcustom(),
    );
  }
}

class IndicatorData {
  final Widget widget;
  final bool isIcon;

  IndicatorData({required this.widget, required this.isIcon});
}
