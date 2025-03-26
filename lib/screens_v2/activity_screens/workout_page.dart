import 'package:flutter/material.dart';
import 'workout_detail_page.dart';

class WorkoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> workoutPlans = [
    {'title': 'Leg Day', 'icon': '🦵'},
    {'title': 'Abs/Core', 'icon': '🧘'},
    {'title': 'Full Body', 'icon': '💪'},
    {'title': 'Biceps & Triceps', 'icon': '🦾'},
    {'title': 'Chest & Shoulders', 'icon': '🦿'},
    {'title': 'Back & Lats', 'icon': '🧱'},
    {'title': 'Create Custom Plan', 'icon': '✏️'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Workout Plan'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: workoutPlans.length,
        itemBuilder: (context, index) {
          final plan = workoutPlans[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Text(plan['icon'], style: const TextStyle(fontSize: 24)),
              title: Text(
                plan['title'],
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 30, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetailPage(planName: plan['title']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
