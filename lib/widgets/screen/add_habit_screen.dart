import 'package:flutter/material.dart';
import 'package:habitformation/datasource/data_source.dart';
import 'package:habitformation/db/model/habit_model.dart';
import 'package:habitformation/utils/core_utils.dart';
import 'package:habitformation/widgets/common/title_text.dart';
import 'package:provider/provider.dart';

class AddHabitScreen extends StatefulWidget {
  static const id = "AddHabitScreen";

  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final dateEditController = TextEditingController();
  final nameEditController = TextEditingController();

  DateTime selectedDate = CoreUtils.removeTimeComponent(DateTime.now());
  String frequency = 'Daily';

  @override
  void initState() {
    super.initState();

    dateEditController.text = CoreUtils.getDateInDDMMYYYY(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 32),
                      TitleText("New Habit"),
                      SizedBox(height: 32),
                      TextField(
                        controller: nameEditController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter a habit',
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: dateEditController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Starting date',
                              ),
                              onTap: () =>
                                  _showDatePickerForStartingDate(context),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () =>
                                _showDatePickerForStartingDate(context),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Frequency",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              _getRadioWidget('Daily', false),
                              _getRadioWidget('Thrice a week', false)
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              _getRadioWidget('Four times a week', false),
                              _getRadioWidget('Once in a week', true)
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            final habitName = nameEditController.text;
                            if (habitName != null && habitName.isNotEmpty) {
                              final habitModel = HabitModel(
                                  name: habitName,
                                  startingDate:
                                      selectedDate.millisecondsSinceEpoch,
                                  repetition: frequency);
                              Provider.of<HabitNotifier>(context, listen: false)
                                  .addHabit(habitModel);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDatePickerForStartingDate(BuildContext context) async {
    final today = DateTime.now();
    final newDay = today.add(Duration(days: -7));
    DateTime selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: newDay,
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );

    setState(() {
      selectedDate = CoreUtils.removeTimeComponent(selectedDateTime);
      dateEditController.text = CoreUtils.getDateInDDMMYYYY(selectedDate);
    });
  }

  Widget _getRadioWidget(String label, bool value) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Radio(
              value: label,
              groupValue: frequency,
              onChanged: (value) {
                setState(() {
                  frequency = label;
                });
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
