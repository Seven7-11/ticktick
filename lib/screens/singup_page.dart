import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SignUpPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // ✅ รองรับ Dark Mode
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/dairy.png', height: 200),
            const SizedBox(height: 20),
            buildTextField("Username", Icons.person),
            const SizedBox(height: 10),
            buildTextField("Email", Icons.email),
            const SizedBox(height: 10),
            buildTextField("Password", Icons.lock, isPassword: true),
            const SizedBox(height: 10),
            buildTextField("Repeat Password", Icons.lock, isPassword: true),
            const SizedBox(height: 20),
            buildButton("Sign Up", Colors.amber, () {
              Navigator.pop(context); // ✅ กด Sign Up แล้วกลับไปหน้า Login
            }),
            const SizedBox(height: 20),
            const Text("Or sign in with:"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSocialIcon("images/apple.png"),
                buildSocialIcon("images/fb.webp"),
                buildSocialIcon("images/goo.png"),
              ],
            ),
            const SizedBox(height: 30),
            buildThemeToggle(), // ✅ ปุ่มสลับโหมด Dark/Light
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, IconData icon, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget buildButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 18, color: Colors.black)),
      ),
    );
  }

  Widget buildSocialIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Image.asset(assetPath, height: 40),
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
          backgroundColor: isSelected ? Colors.amber : Colors.grey[700], // ✅ เปลี่ยนสีปุ่ม
          foregroundColor: isSelected ? Colors.black : Colors.white, // ✅ เปลี่ยนสีตัวอักษร
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          splashFactory: InkSplash.splashFactory, // ✅ เพิ่มเอฟเฟกต์กดปุ่ม
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
