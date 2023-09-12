import 'package:flutter/material.dart';
// import 'package:tasks/widgets/task_card.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Favorite screen works!",
            style: TextStyle(color: Colors.white),
          )
        ],
      )),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteTasks;

  const FavoritesPage({required this.favoriteTasks});

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: favoriteTasks.length,
    //   itemBuilder: (context, index) {
    //     final task = favoriteTasks[index];
    //     return TaskCard(
    //         title: task['title'],
    //         descrption: task['description'],
    //         dueDate: task['dueDate']);
    //   },
    // );
    return Center(
      child: Text(
        'favorites works!',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
