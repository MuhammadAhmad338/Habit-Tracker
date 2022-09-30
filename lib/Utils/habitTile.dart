// ignore_for_file: file_names, unused_local_variable, prefer_interpolation_to_compose_strings
import "package:flutter/material.dart";
import 'package:percent_indicator/percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int timeGoal;
  final bool isHabitStarted;

  const HabitTile(
      {super.key,
      required this.habitName,
      required this.onTap,
      required this.settingsTapped,
      required this.timeSpent,
      required this.timeGoal,
      required this.isHabitStarted});

  formatToMinSeconds(int totalSeconds) {
    String seconds = (totalSeconds % 60).toString();
    String minutes = (totalSeconds / 60).toStringAsFixed(5);

    if (seconds.length == 1) {
      seconds = "0" + seconds;
    }

    if (minutes[1] == ".") {
      minutes = minutes.substring(0, 1);
    }

    return minutes + ":" + seconds;
  }

  double percentageCompleted() {
    return timeSpent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Stack(children: [
                    CircularPercentIndicator(
                        radius: 30,
                        percent: percentageCompleted() < 1
                            ? percentageCompleted()
                            : 1,
                        progressColor: percentageCompleted() > 0.75
                            ? Colors.green
                            : percentageCompleted() > 0.5
                                ? Colors.orange
                                : Colors.red),
                    Center(
                        child: isHabitStarted
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow)),
                  ])),
            ),
            const SizedBox(width: 15),
            Column(children: [
              Text(
                habitName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(formatToMinSeconds(timeSpent) +
                  " / " +
                  timeGoal.toString() +
                  " = " +
                  (percentageCompleted() * 100).toStringAsFixed(0) +
                  "%")
            ]),
          ]),
          GestureDetector(
              onTap: settingsTapped, child: const Icon(Icons.settings))
        ]),
      ),
    );
  }
}
