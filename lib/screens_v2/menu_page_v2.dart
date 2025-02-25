import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MenuPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text("Menu"),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildMenuItem(Icons.person, "Account"),
            buildMenuItem(Icons.local_fire_department, "Activity"),
            buildMenuItem(Icons.hearing, "Hearing"),
            buildMenuItem(Icons.phone_iphone, "Phone Time"),
            buildMenuItem(Icons.checklist, "Daily to do list"),
            buildMenuItem(Icons.attach_money, "Financial Management"),
            buildMenuItem(Icons.track_changes, "Personal goal setting"),
            const SizedBox(height: 20),
            buildThemeToggle(),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.black),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildThemeToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildThemeButton("☀️ Light Mode", !isDarkMode, () {
          onThemeChanged(false);
        }),
        buildThemeButton("🌙 Dark Mode", isDarkMode, () {
          onThemeChanged(true);
        }),
      ],
    );
  }

  Widget buildThemeButton(String text, bool isSelected, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.amber : Colors.grey[700],
          foregroundColor: isSelected ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
