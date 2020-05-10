import 'package:flutter/material.dart';
import 'package:habitformation/widgets/screen/add_habit_screen.dart';
import 'package:habitformation/widgets/screen/habit_screen.dart';
import 'package:provider/provider.dart';

import 'datasource/data_source.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HabitNotifier(),
      lazy: false,
      child: MaterialApp(
        title: 'Habit Formation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonColor: Color(0xFF5478F2),
          accentColor: Color(0xFF2E2F31),
          scaffoldBackgroundColor: Color(0xFFEAEAF2),
        ),
        initialRoute: HabitScreen.id,
        routes: {
          HabitScreen.id: (context) => HabitScreen(),
          AddHabitScreen.id: (context) => AddHabitScreen(),
        },
      ),
    );
  }
}
