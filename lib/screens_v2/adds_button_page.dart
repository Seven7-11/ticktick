import 'package:flutter/material.dart';
import 'package:ticktick/screens_v2/notification_page.dart';
import 'package:ticktick/screens_v2/habit_page_v2.dart' as habit;
import 'package:ticktick/screens_v2/accont_page.dart';

class AddButtonPage extends StatefulWidget {
  const AddButtonPage({super.key});

  @override
  _AddButtonPageState createState() => _AddButtonPageState();
}

class _AddButtonPageState extends State<AddButtonPage> {
  List<Map<String, dynamic>> habits = [
    {"icon": Icons.directions_run, "title": "Swim", "progress": 2.5, "total": 5.0, "unit": "hr"},
    {"icon": Icons.fitness_center, "title": "Yoga", "progress": 2.5, "total": 5.0, "unit": "hr"},
    {"icon": Icons.directions_walk, "title": "Food", "progress": 2.5, "total": 5.0, "unit": "cal"},
    {"icon": Icons.fitness_center, "title": "Drunk", "progress": 2.5, "total": 5.0, "unit": "ml"},
  ];

  // ✅ ฟังก์ชันเพิ่ม Habit ใหม่ลงใน List
  void _addHabit(String title) {
    setState(() {
      habits.add({
        "icon": Icons.directions_run,
        "title": title,
        "progress": 0.0, // ✅ เปลี่ยนเป็น double
        "total": 10.0, // ✅ เปลี่ยนเป็น double
        "unit": "times",
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Habit",
          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Habits", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return HabitCard(
                    icon: habits[index]["icon"],
                    title: habits[index]["title"],
                    progress: habits[index]["progress"],
                    total: habits[index]["total"],
                    unit: habits[index]["unit"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddHabitDialog(context);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.yellow,
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
          } else if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => habit.HabitPage(isDarkMode: false, onThemeChanged: (value) {})),
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
    );
  }

  // ✅ ฟังก์ชันเปิด Dialog เพิ่ม Habit
  void _showAddHabitDialog(BuildContext context) {
    TextEditingController habitController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Habit"),
          content: TextField(
            controller: habitController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Habit",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (habitController.text.isNotEmpty) {
                  _addHabit(habitController.text);
                }
                Navigator.pop(context);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
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
