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
import 'package:tasks/widgets/task_card.dart';

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

List<Map<String, dynamic>> taskLists = [
  {
    'title': 'Task List 1',
    'tasks': [
      {
        'title': 'Task 1 for tasklist 1',
        'description': 'Description 1 for tasklist 1',
        'dueDate': '2023-12-31'
      },
      {
        'title': 'Task 2 for tasklist 1',
        'description': 'Description 2 for tasklist 1',
        'dueDate': '2023-12-30'
      },
      // Add more tasks as needed
    ],
  },
  {
    'title': 'Task List 2',
    'tasks': [
      {
        'title': 'Task 1 for tasklist 2',
        'description': 'Description 1 for tasklist 2',
        'dueDate': '2023-12-31'
      },
      {
        'title': 'Task 2 for tasklist 2',
        'description': 'Description 2 for tasklist 2',
        'dueDate': '2023-12-30'
      },
      // Add more tasks as needed
    ],
  },
  {
    'title': 'Task List 3',
    'tasks': [
      {
        'title': 'Task 1 for tasklist 3',
        'description': 'Description 1 for tasklist 3',
        'dueDate': '2023-12-31 '
      },
      {
        'title': 'Task 2 for tasklist 3',
        'description': 'Description 2 for tasklist 3',
        'dueDate': '2023-12-30'
      },
      // Add more tasks as needed
    ],
  },
  // Add more task lists as needed
];

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
  late PageController _pageController;
  List<Map<String, dynamic>> favoriteTasks = []; // Store favorite tasks here
  int currentPageIndex = 1;

  final List<Widget> screens = [
    Favorites(),
    MyTasks(),
    AddScreen(),
    // OtherTaskScreen(),
    // Add more screens as needed
  ];
  List<Widget> generateTaskListScreens() {
    return taskLists.map((taskList) {
      return TaskListScreen(taskList: taskList);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  final List<Widget> pages = [
    //   FavoritesPage(favoriteTasks: favoriteTasks), // Favorites page
    //   generateTaskListScreens(), // Other task list pages
    // ];
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(taskLists.length, (index) {
                final isActive = index == currentPageIndex;

                return GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(index);
                  },
                  child: Text(
                    taskLists[index]['title'],
                    style: TextStyle(
                      color: isActive ? Colors.blue : Colors.white,
                    ),
                  ),
                );
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
              children: taskLists.map((taskList) {
                return TaskListScreen(taskList: taskList);
              }).toList(),
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

// class TaskListScreen extends StatefulWidget {
//   final Map<String, dynamic> taskList;

//   const TaskListScreen({required this.taskList});

//   @override
//   _TaskListScreenState createState() => _TaskListScreenState();
// }

// class _TaskListScreenState extends State<TaskListScreen> {
//   late PageController
//       _pageController; // Declare as late to ensure initialization

//   @override
//   void initState() {
//     super.initState();
//     _pageController =
//         PageController(initialPage: 0); // Initialize _pageController
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> tasks = widget.taskList['tasks'];

//     return PageView.builder(
//       controller: _pageController,
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         final task = tasks[index];
//         return TaskCard(
//           title: task['title'],
//           descrption: task['description'],
//           dueDate: task['dueDate'],
//         );
//       },
//     );
//   }
// }

class TaskListScreen extends StatelessWidget {
  final Map<String, dynamic> taskList;

  const TaskListScreen({required this.taskList});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tasks = taskList['tasks'];

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          title: task['title'],
          descrption: task['description'],
          dueDate: task['dueDate'],
        );
      },
    );
  }
}
