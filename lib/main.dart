import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:tasks/assets/variables.dart';
import 'package:tasks/auth/data_retrive.dart';
import 'package:tasks/auth/task_manager.dart';
import 'package:tasks/screens/NotFoundScreen.dart';
// import 'package:tasks/screens/add_list.dart';
import 'package:tasks/screens/add_screen.dart';
import 'package:tasks/screens/favorites.dart';
import 'package:tasks/screens/login.dart';
import 'package:tasks/screens/my_tasks.dart';
import 'package:tasks/screens/profile.dart';
import 'package:tasks/screens/register.dart';
import 'package:tasks/widgets/btmnavbar.dart';
import 'package:tasks/widgets/task_card.dart';

// var GlobalTaskLists = [];

void main() {
  // GlobalTaskLists = []; // Initialize the global variable here

  runApp(const MyApp());
}

// final prefs =  SharedPreferences.getInstance();
//   var userId1 = prefs.getString('userId') ?? '';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentTaskListId = ''; // Declare it here
  late PageController _pageController;
  List<Map<String, dynamic>> favoriteTasks = []; // Store favorite tasks here
  int currentPageIndex = 1;
  List<Map<String, dynamic>> taskLists = []; // Define taskLists
  int currentTaskListIndex = 0;

  final List<Widget> screens = [
    Favorites(),
    MyTasks(),
    AddScreen(),
    // OtherTaskScreen(),
    // Add more screens as needed
  ];

  // void _pageChanged() {
  //   setState(() {
  //     currentTaskListIndex = _pageController.page?.round() ?? 0;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageIndex);
    // _pageController.addListener(_pageChanged); // Listen to page changes
    // print('userId from init homescreen : $userId');

    getTasks(userId).then((taskListData) {
      setState(() {
        taskLists = taskListData;
        print('printing taskListData from setState : $taskListData');
      });
    });

    // Listen to page changes and update currentTaskListId
    _pageController.addListener(() {
      setState(() {
        currentTaskListId =
            taskLists[_pageController.page?.round() ?? 0]['_id'] ?? '';
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
          Container(
            height: 50,
            color: Colors.black,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(taskLists?.length ?? 0, (index) {
                  final isActive = index == currentPageIndex;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(index);
                        setState(() {
                          currentPageIndex = index;
                          currentTaskListIndex = index;
                        });
                      },
                      child: Text(
                        taskLists![index]['title'],
                        style: TextStyle(
                          color: isActive ? Colors.blue : Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                  currentTaskListIndex = index;
                });
              },
              children: taskLists.map((taskList) {
                return TaskListScreen(taskList: taskList);
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarcustom(
        currentTaskListId: currentTaskListId, // Pass the currentTaskListId
        onNavItemPressed: (taskListId) {
          setState(() {
            currentTaskListId = taskListId; // Update the currentTaskListId
          });
        },
      ),
    );
  }
}

class IndicatorData {
  final Widget widget;
  final bool isIcon;

  IndicatorData({required this.widget, required this.isIcon});
}

class TaskListScreen extends StatefulWidget {
  final Map<String, dynamic> taskList;

  const TaskListScreen({required this.taskList});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final tasks = widget.taskList['tasks']; // Use widget.taskList here
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          taskId: task['_id'],
          title: task['title'],
          descrption: task['description'],
          dueDate: task['dueDate'],
        );
      },
    );
  }
}
