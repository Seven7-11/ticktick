import 'package:flutter/material.dart';

import 'package:ticktick/screens_v2/habit_page_v2.dart' as habit;
import 'package:ticktick/screens_v2/account_page.dart';
import 'package:ticktick/screens_v2/notification_page.dart';

import 'notification_page.dart';

class AddButtonPage extends StatefulWidget {
  const AddButtonPage({super.key});

  @override
  _AddButtonPageState createState() => _AddButtonPageState();
}

class _AddButtonPageState extends State<AddButtonPage> {
  List<Map<String, dynamic>> habits = [];

  void _addHabit(String title) {
    setState(() {
      habits.add({
        "icon": Icons.directions_run,
        "title": title,
        "progress": 0.0,
        "total": 10.0,
        "unit": "times",
      });
    });
  }

  void _confirmDeleteHabit(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ยืนยันการลบ"),
          content: const Text("คุณแน่ใจหรือไม่ว่าต้องการลบรายการนี้?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ยกเลิก"),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteHabit(index);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("ลบ", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _deleteHabit(int index) {
    setState(() {
      habits.removeAt(index);
    });
  }

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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Habits", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: habits.isEmpty
                  ? const Center(
                child: Text(
                  "ยังไม่มี Habit โปรดกดปุ่ม + เพื่อเพิ่ม",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(habits[index]["title"]),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white, size: 30),
                    ),
                    confirmDismiss: (direction) async {
                      _confirmDeleteHabit(index);
                      return false;
                    },
                    child: HabitCard(
                      icon: habits[index]["icon"],
                      title: habits[index]["title"],
                      progress: habits[index]["progress"],
                      total: habits[index]["total"],
                      unit: habits[index]["unit"],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountScreen()));
          } else if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => habit.HabitPage(
                  isDarkMode: false,
                  onThemeChanged: (value) {},
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
    );
  }

  void _showAddHabitDialog(BuildContext context) {
    TextEditingController habitController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.grey[200],
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add Habit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: habitController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Habit",
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
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
                ),
              ],
            ),
          ),
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
