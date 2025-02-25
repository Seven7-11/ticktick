import 'package:flutter/material.dart';
import 'package:ticktick/screens_v2/singup_page_v2.dart';
import 'package:ticktick/screens_v2/habit_page_v2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: LoginPage(
        isDarkMode: isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const LoginPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/dairy.png', height: 200),
            const SizedBox(height: 20),
            buildTextField("Username", Icons.person),
            const SizedBox(height: 10),
            buildTextField("Password", Icons.lock, isPassword: true),
            const SizedBox(height: 20),
            buildButton("Login", Colors.amber, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HabitPage(
                    isDarkMode: isDarkMode,
                    onThemeChanged: onThemeChanged,
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(
                      isDarkMode: isDarkMode,
                      onThemeChanged: onThemeChanged,
                    ),
                  ),
                );
              },
              child: const Text("Sign Up", style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Forgot Password?", style: TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: buildSocialIcon("images/apple.png")),
                Expanded(child: buildSocialIcon("images/fb.webp")),
                Expanded(child: buildSocialIcon("images/goo.png")),
              ],
            ),
            const SizedBox(height: 30),
            buildThemeToggle(),
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
