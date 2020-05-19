import 'package:flutter/material.dart';
import 'package:habitformation/datasource/data_source.dart';
import 'package:habitformation/widgets/animation/base_container.dart';
import 'package:habitformation/widgets/common/habit_header_widget.dart';
import 'package:habitformation/widgets/common/title_text.dart';
import 'package:habitformation/widgets/common/week_widget.dart';
import 'package:habitformation/widgets/screen/add_habit_screen.dart';
import 'package:provider/provider.dart';

class HabitScreen extends StatelessWidget {
  static const id = "HabitScreen";

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitNotifier>(
      builder: (context, habitsNotifier, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Color(0xFFEAEAF2),
                expandedHeight: 110.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: TitleText('Habit Formation',
                      fontSize: 24, color: Colors.black),
                  centerTitle: false,
                  titlePadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
                ),
              ),
              SliverPadding(
                  padding: EdgeInsets.only(top: 24, left: 16.0, right: 16.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final habit = habitsNotifier.habits[index];
                      return getHabitInfo(habit.name, habit.repetition, index);
                    }, childCount: habitsNotifier.habits.length),
                  )),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddHabitScreen.id);
            },
            child: Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }

  Widget getHabitInfo(String title, String frequency, int index) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        BaseContainer(color: Color(0xFF2D2E30)),
        BaseContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: <Widget>[
                HabitHeaderWidget(
                  title: title,
                  routineInfo: frequency,
                  iconData: Icons.calendar_today,
                ),
                SizedBox(
                  height: 24,
                ),
                WeekWidget(index),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
