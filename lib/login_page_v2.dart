import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_options.dart';
import 'package:ticktick/screens_v2/habit_page_v2.dart';
import 'package:ticktick/screens_v2/forgot_password_page.dart';
import 'package:ticktick/screens_v2/singup_page_v2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
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
        onThemeChanged: (value) {
          setState(() => isDarkMode = value);
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

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HabitPage(
            isDarkMode: isDarkMode,
            onThemeChanged: onThemeChanged,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset('images/dairy.png', height: 200),
              const SizedBox(height: 20),
              buildTextField("Email", Icons.person, controller: emailController),
              const SizedBox(height: 10),
              buildTextField("Password", Icons.lock, isPassword: true, controller: passwordController),
              const SizedBox(height: 20),
              buildButton("Login", Colors.amber, () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("กรุณากรอกอีเมลและรหัสผ่าน")),
                  );
                  return;
                }

                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HabitPage(
                        isDarkMode: isDarkMode,
                        onThemeChanged: onThemeChanged,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("เข้าสู่ระบบล้มเหลว: $e")),
                  );
                }
              }),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => SignUpPage(
                      isDarkMode: isDarkMode,
                      onThemeChanged: onThemeChanged,
                    ),
                  ));
                },
                child: const Text("Sign Up"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => ForgotPasswordPage(
                      isDarkMode: isDarkMode,
                      onThemeChanged: onThemeChanged,
                    ),
                  ));
                },
                child: const Text("Forgot Password?"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: buildSocialIcon("images/apple.png")),
                  Expanded(child: buildSocialIcon("images/fb.webp")),
                  Expanded(
                    child: InkWell(
                      onTap: () => _signInWithGoogle(context),
                      child: buildSocialIcon("images/goo.png"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              buildThemeToggle(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, IconData icon, {bool isPassword = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
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
