// ignore_for_file: file_names, avoid_print, unused_local_variable
import 'dart:async';

import "package:flutter/material.dart";
import 'package:habit_tracker/Utils/habitTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List listOfHabits = [
    ["Meditate", false, 0, 1],
    ["Code App", false, 0, 1],
    ["Do Exercise", false, 0, 2],
    ["Ahmad", false, 0, 3]
  ];

  isHabitStarting(int index) {
    var startTime = DateTime.now();

    //Elapsed time that is already went through or gone / through
    int elapsedTime = listOfHabits[index][2];

    setState(() {
      listOfHabits[index][1] = !listOfHabits[index][1];
    });

    if (listOfHabits[index][1]) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (listOfHabits[index][1] == false) {
            timer.cancel();
          }

          var currentTime = DateTime.now();
          listOfHabits[index][2] = elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  settingsOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Hello Ahmad ${listOfHabits[index][0]}"));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            title: const Text("Consistency is key."),
            backgroundColor: Colors.grey[900]),
        body: ListView.builder(
            itemCount: listOfHabits.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: listOfHabits[index][0],
                onTap: () => isHabitStarting(index),
                settingsTapped: () => settingsOpened(index),
                timeSpent: listOfHabits[index][2],
                timeGoal: listOfHabits[index][3],
                isHabitStarted: listOfHabits[index][1],
              );
            }));
  }
}
