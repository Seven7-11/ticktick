import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ticktick/screens/menu_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme(bool isDark) {
    setState(() {
      isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: ActivityScreen(isDarkMode: isDarkMode, onThemeChanged: toggleTheme),
    );
  }
}

class ActivityScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  ActivityScreen({required this.isDarkMode, required this.onThemeChanged});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Activity", style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          buildThemeToggle(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('images/chakkapat.png'),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDateCircle("mon", "6", widget.isDarkMode ? Colors.white : Colors.black),
                      _buildDateCircle("tue", "7", widget.isDarkMode ? Colors.white : Colors.black),
                      _buildDateCircle("wed", "8", widget.isDarkMode ? Colors.white : Colors.black),
                      _buildDateCircle("thr", "9", Colors.yellow),
                      _buildDateCircle("fri", "10", widget.isDarkMode ? Colors.white : Colors.black),
                      _buildDateCircle("sat", "11", widget.isDarkMode ? Colors.white : Colors.black),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuPage(
                          isDarkMode: widget.isDarkMode, // ✅ ส่งค่า isDarkMode
                          onThemeChanged: widget.onThemeChanged, // ✅ ส่งค่า onThemeChanged
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                _buildCalorieTracker(),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCircularProgressIndicator("Protein", 75, Colors.yellow),
                    SizedBox(height: 10),
                    _buildCircularProgressIndicator("Fats", 60, widget.isDarkMode ? Colors.white : Colors.black),
                    SizedBox(height: 10),
                    _buildCircularProgressIndicator("Carb", 25, Colors.grey),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildInfoCard("Water", "2.1 Liters", Icons.water_drop, Colors.yellow)),
                SizedBox(width: 10),
                Expanded(child: _buildInfoCard("Sleep", "8 Hours", Icons.nightlight_round, widget.isDarkMode ? Colors.white : Colors.black)),
              ],
            ),
            SizedBox(height: 50),
            Text("Today's Activity", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildActivityCard("Run", "2.5 / 5 KM", "7:50 AM", Icons.directions_run),
                  _buildActivityCard("Weight Training", "2.5 / 5 Hr", "9:50 AM", Icons.fitness_center),
                  _buildActivityCard("Walk", "2.5 / 5 Hr", "10:50 AM", Icons.directions_walk),
                ],
              ),
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
        IconButton(
          icon: Icon(Icons.wb_sunny, color: widget.isDarkMode ? Colors.grey : Colors.yellow),
          onPressed: () => widget.onThemeChanged(false),
        ),
        IconButton(
          icon: Icon(Icons.nightlight_round, color: widget.isDarkMode ? Colors.yellow : Colors.grey),
          onPressed: () => widget.onThemeChanged(true),
        ),
      ],
    );
  }
}
Widget _buildDateCircle(String day, String date, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              date,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(day, style: TextStyle(color: Colors.black, fontSize: 12)),
      ],
    ),
  );
}

Widget _buildCalorieTracker() {
  return Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: 0.7,
              strokeWidth: 8,
              backgroundColor: Colors.white,
              color: Colors.black,
            ),
          ),
          Text("730 Kcal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

Widget _buildCircularProgressIndicator(String title, double value, Color color) {
  return Row(
    children: [
      Container(
        width: 60,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: value / 100,
                strokeWidth: 6,
                backgroundColor: Colors.greenAccent,
                color: color,
              ),
            ),
            Text("${value.toInt()}%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      SizedBox(width: 10),
      Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
            Text(value, style: TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
        Icon(icon, color: Colors.white, size: 24),
      ],
    ),
  );
}

Widget _buildActivityCard(String activity, String progress, String time, IconData icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 30, color: Colors.black),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(progress, style: TextStyle(fontSize: 14, color: Colors.black)),
              ],
            ),
          ],
        ),
        Text(time, style: TextStyle(fontSize: 14, color: Colors.black)),
      ],
    ),
  );
}







