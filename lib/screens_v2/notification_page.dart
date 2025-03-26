import 'package:flutter/material.dart';
import '../screens_v2/habit_page_v2.dart' as habit;
import '../screens_v2/account_page.dart';


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black, //
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Activity",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            NotificationCard(
              icon: Icons.directions_run,
              title: "Run",
              time: "10:30",
            ),
            NotificationCard(
              icon: Icons.fitness_center,
              title: "Gym",
              time: "13:00",
            ),
            NotificationCard(
              icon: Icons.directions_walk,
              title: "Walk",
              time: "05:30",
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String time;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool isSwitched = true;
  String selectedTime = "";

  @override
  void initState() {
    super.initState();
    selectedTime = widget.time;
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(widget.time.split(":")[0]) ?? 10,
        minute: int.tryParse(widget.time.split(":")[1]) ?? 30,
      ),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(widget.icon, size: 32, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          InkWell(
            onTap: () => _pickTime(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                selectedTime,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() => isSwitched = value);
            },
            activeColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
