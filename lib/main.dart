import 'package:flutter/material.dart';
import 'screens/movie_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MovieList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
