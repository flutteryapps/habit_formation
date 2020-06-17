import 'package:flutter/material.dart';
import 'package:habitformation/datasource/data_source.dart';
import 'package:habitformation/widgets/animation/base_container.dart';
import 'package:habitformation/widgets/animation/swipe_animation.dart';
import 'package:habitformation/widgets/common/habit_header_widget.dart';
import 'package:habitformation/widgets/common/habit_update.dart';
import 'package:habitformation/widgets/common/title_text.dart';
import 'package:habitformation/widgets/common/week_widget.dart';
import 'package:provider/provider.dart';

import 'add_habit_screen.dart';

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
                      return getHabitInfo(context, habit.name, habit.repetition,
                          index, habitsNotifier);
                    }, childCount: habitsNotifier.habits.length),
                  )),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text("ADD HABIT"),
            onPressed: () =>
                Navigator.pushNamed(context, AddHabitScreen.id, arguments: -1),
          ),
        );
      },
    );
  }

  Widget getHabitInfo(BuildContext context, String title, String frequency,
      int index, HabitNotifier habitsNotifier) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: BaseContainer(
            color: Color(0xFF2D2E30),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: HabitUpdate(
                onEdit: () {
                  Navigator.pushNamed(context, AddHabitScreen.id,
                      arguments: habitsNotifier.habits[index].id);
                },
                onDelete: () {
                  habitsNotifier.deleteHabit(habitsNotifier.habits[index].id);
                },
              ),
            ),
          ),
        ),
        SwipeAnimation(
          child: BaseContainer(
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
                  SizedBox(height: 16),
                  WeekWidget(index),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
