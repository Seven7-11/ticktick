import 'package:flutter/material.dart';
import 'workout_detail_page.dart';
import 'create_custom_plan_page.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      {'icon': '🦵', 'title': 'Leg Day'},
      {'icon': '🧘', 'title': 'Abs/Core'},
      {'icon': '💪', 'title': 'Full Body'},
      {'icon': '🦾', 'title': 'Biceps & Triceps'},
      {'icon': '🏋️‍♂️', 'title': 'Chest & Shoulders'},
      {'icon': '📦', 'title': 'Back & Lats'},
      {'icon': '✏️', 'title': 'Create Custom Plan'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Plan'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: ListTile(
                leading: Text(plan['icon']!, style: const TextStyle(fontSize: 30)),
                title: Text(
                  plan['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20, // 👈 ลองเริ่มที่ 20 หรือ 22
                    fontWeight: FontWeight.w600,
                  ),
                ),

                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onTap: () {
                  if (plan['title'] == 'Create Custom Plan') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateCustomPlanPage()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutDetailPage(planName: plan['title']!),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
