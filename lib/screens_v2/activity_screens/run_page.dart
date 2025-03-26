import 'dart:async';
import 'package:flutter/material.dart';
import '../habit_model.dart';

class RunPage extends StatefulWidget {
  final Habit habit;

  const RunPage({super.key, required this.habit});

  @override
  State<RunPage> createState() => _RunPageState();
}

class _RunPageState extends State<RunPage> {
  bool isRunning = false;
  double distance = 0.0;
  Duration elapsedTime = Duration.zero;
  Timer? timer;

  final Color backgroundColor = Colors.white;

  void startRun() {
    isRunning = true;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        elapsedTime += const Duration(seconds: 1);
        distance += 0.01;
        widget.habit.progress = distance;
        if (widget.habit.progress > widget.habit.total) {
          widget.habit.progress = widget.habit.total;
        }
      });
    });
  }

  void stopRun() {
    timer?.cancel();
    timer = null;
    setState(() {
      isRunning = false;
    });
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          "Run Tracker",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🕒 เวลา ด้านขวาบน
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Time",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Text(
                        formatDuration(elapsedTime),
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              
              const Spacer(),
              Text(
                "${distance.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
              ),
              const Text(
                "kilometres",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: isRunning ? stopRun : startRun,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.black,
                ),
                child: Icon(
                  isRunning ? Icons.pause : Icons.play_arrow,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Music ?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next, color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
