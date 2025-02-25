import 'package:flutter/material.dart';
import 'package:ticktick/screens_v2/notification_page.dart'; // ✅ Import หน้า Notification
import 'package:ticktick/screens_v2/habit_page_v2.dart' as habit; // ✅ Import หน้า Habit

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountScreen(),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // ✅ ตั้งค่าให้ไอคอน "Person" เป็นหน้าปัจจุบัน
        onTap: (index) {
          if (index == 0) { // ✅ กด "Favorite" แล้วไปหน้า HabitPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => habit.HabitPage(isDarkMode: false, onThemeChanged: (value) {})),
            );
          } else if (index == 1) { // ✅ กด "Notifications" แล้วไปหน้า NotificationPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""), // ✅ กดไปหน้า HabitPage
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""), // ✅ กดไปหน้า NotificationPage
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""), // ✅ หน้าปัจจุบัน (Account)
          BottomNavigationBarItem(icon: Icon(Icons.nightlight_round), label: ""),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Account',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/chakkapat.png'),
            ),
            const SizedBox(height: 10),
            const Text(
              'chakkapat.w@kkumail.com',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            InfoBox(text: 'Name: Chakkapt Waenmook'),
            InfoBox(text: 'Email: chakkapat.w@kkumail.com'),
            InfoBox(text: 'Phone:  086-199-xxxx'),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String text;

  const InfoBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.yellow[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
