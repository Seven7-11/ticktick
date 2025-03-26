import 'package:flutter/material.dart';
import 'activity_screens/run_page.dart';
import 'activity_screens/walk_page.dart';
import 'activity_screens/workout_page.dart';
import 'package:ticktick/screens_v2/notification_page.dart';
import 'package:ticktick/screens_v2/account_page.dart';
import 'package:ticktick/screens_v2/adds_button_page.dart'; // ✅ Add Habit Page
import 'package:ticktick/screens_v2/habit_model.dart';
import 'package:ticktick/screens_v2/display_mode_page.dart'; // ✅ Display Mode Page

class HabitPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HabitPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Habit"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Activity", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ActivityCard(
                    icon: Icons.directions_run,
                    title: "Run",
                    progress: 2.5,
                    total: 5,
                    unit: "km",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RunPage(
                            habit: Habit(name: "Run", unit: "km", total: 5, progress: 2.5),
                          ),
                        ),
                      );
                    },
                  ),
                  ActivityCard(
                    icon: Icons.fitness_center,
                    title: "Work-out",
                    progress: 2.5,
                    total: 5,
                    unit: "Hr",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WorkoutPage()),
                      );
                    },
                  ),
                  ActivityCard(
                    icon: Icons.directions_walk,
                    title: "Walk",
                    progress: 2.5,
                    total: 5,
                    unit: "Hr",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WalkPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddButtonPage()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            } else if (index == 3) { // ✅ Display mode
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayModePage(
                    isDarkMode: isDarkMode,
                    onThemeChanged: onThemeChanged,
                  ),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.nightlight_round), label: ""),
          ],
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double progress;
  final double total;
  final String unit;
  final VoidCallback? onTap;

  const ActivityCard({
    super.key,
    required this.icon,
    required this.title,
    required this.progress,
    required this.total,
    required this.unit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("$progress / $total $unit", style: const TextStyle(color: Colors.amber, fontSize: 14)),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: progress / total,
                      backgroundColor: Colors.grey,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Text("10.50 AM", style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
