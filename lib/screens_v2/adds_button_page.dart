import 'package:flutter/material.dart';
import 'package:ticktick/screens_v2/notification_page.dart'; // หน้า Notification
import 'package:ticktick/screens_v2/habit_page_v2.dart' as habit; // หน้า Habit
import 'package:ticktick/screens_v2/accont_page.dart'; //  หน้า Account

class AddButtonPage extends StatelessWidget {
  const AddButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Habit",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            HabitCard(icon: Icons.directions_run, title: "Swim", progress: 2.5, total: 5, unit: "hr"),
            HabitCard(icon: Icons.fitness_center, title: "Yoga", progress: 2.5, total: 5, unit: "hr"),
            const SizedBox(height: 20),
            const Text("Eat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            HabitCard(icon: Icons.directions_walk, title: "Food", progress: 2.5, total: 5, unit: "cal"),
            HabitCard(icon: Icons.fitness_center, title: "Drunk", progress: 2.5, total: 5, unit: "ml"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: 0, //  ตั้งให้ "Favorite" เป็นหน้าปัจจุบัน
        onTap: (index) {
          if (index == 1) { //  กด "Notifications" ไปหน้า Notification
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          } else if (index == 2) { //  กด "Person" ไปหน้า Account
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
          } else if (index == 0) { //  กด "Favorite" กลับไปหน้า Habit
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => habit.HabitPage(isDarkMode: false, onThemeChanged: (value) {})),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""), //  กดกลับไปหน้า Habit
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""), //  ไปหน้า Notification
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""), //  ไปหน้า Account
          BottomNavigationBarItem(icon: Icon(Icons.nightlight_round), label: ""),
        ],
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double progress;
  final double total;
  final String unit;

  const HabitCard({
    super.key,
    required this.icon,
    required this.title,
    required this.progress,
    required this.total,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
          ],
        ),
      ),
    );
  }
}
