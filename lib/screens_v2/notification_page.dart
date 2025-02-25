import 'package:flutter/material.dart';
import 'package:ticktick/screens_v2/habit_page_v2.dart' as habit; // ✅ Import Habit Page
import 'package:ticktick/screens_v2/accont_page.dart'; // ✅ Import Account Page

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Activity", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 10),
            NotificationCard(icon: Icons.directions_run, title: "Run", time: "10 : 30"),
            NotificationCard(icon: Icons.fitness_center, title: "Gym", time: "13 : 00"),
            NotificationCard(icon: Icons.directions_walk, title: "Walk", time: "05 : 30"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: 1, // ✅ ตั้งให้ Notifications เป็นหน้าปัจจุบัน
        onTap: (index) {
          if (index == 0) { // ✅ กด "Favorite" ไปที่ Habit Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => habit.HabitPage(isDarkMode: false, onThemeChanged: (value) {})),
            );
          } else if (index == 2) { // ✅ กด "Person" ไปที่ Account Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""), // ✅ กดไป Habit Page
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""), // ✅ อยู่ที่ Notifications Page
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""), // ✅ กดไป Account Page
          BottomNavigationBarItem(icon: Icon(Icons.nightlight_round), label: ""),
        ],
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String time;

  const NotificationCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.time,
  }) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            Icon(widget.icon, color: Colors.white, size: 40),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(widget.time, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Switch(
              value: isSwitched,
              activeColor: Colors.amber,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
