import 'dart:async';
import 'package:flutter/material.dart';
import 'workout_page.dart';

class WalkPage extends StatefulWidget {
  const WalkPage({super.key});

  @override
  State<WalkPage> createState() => _WalkPageState();
}

class _WalkPageState extends State<WalkPage> {
  int steps = 0;
  Duration elapsed = Duration.zero;
  Timer? timer;
  bool isWalking = false;

  void startWalking() {
    isWalking = true;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        elapsed += const Duration(seconds: 1);
        steps += 2;
      });
    });
  }

  void stopWalking() {
    timer?.cancel();
    setState(() {
      isWalking = false;
    });
  }

  String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "WALK",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Time",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        formatTime(elapsed),
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "$steps",
                style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                "steps",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: isWalking ? stopWalking : startWalking,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.black,
                ),
                child: Icon(
                  isWalking ? Icons.pause : Icons.play_arrow,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  timer?.cancel();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const WorkoutPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                icon: const Icon(Icons.check),
                label: const Text("Save & Back to Workout"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
