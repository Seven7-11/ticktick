import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkoutDetailPage extends StatelessWidget {
  final String planName;

  WorkoutDetailPage({required this.planName});

  final Map<String, List<Map<String, String>>> workoutDetails = {
    'Leg Day': [
      {'name': 'Squats', 'url': 'https://www.youtube.com/watch?v=aclHkVaku9U'},
      {'name': 'Lunges', 'url': 'https://www.youtube.com/watch?v=QOVaHwm-Q6U'},
      {'name': 'Leg Press', 'url': 'https://www.youtube.com/watch?v=IZxyjW7MPJQ'},
    ],
    'Abs/Core': [
      {'name': 'Plank', 'url': 'https://www.youtube.com/watch?v=pSHjTRCQxIw'},
      {'name': 'Crunches', 'url': 'https://www.youtube.com/watch?v=Xyd_fa5zoEU'},
      {'name': 'Russian Twists', 'url': 'https://www.youtube.com/watch?v=wkD8rjkodUI'},
    ],
    'Full Body': [
      {'name': 'Burpees', 'url': 'https://www.youtube.com/watch?v=TU8QYVW0gDU'},
      {'name': 'Jumping Jacks', 'url': 'https://www.youtube.com/watch?v=c4DAnQ6DtF8'},
      {'name': 'Mountain Climbers', 'url': 'https://www.youtube.com/watch?v=nmwgirgXLYM'},
    ],
    'Biceps & Triceps': [
      {'name': 'Bicep Curls', 'url': 'https://www.youtube.com/watch?v=ykJmrZ5v0Oo'},
      {'name': 'Tricep Dips', 'url': 'https://www.youtube.com/watch?v=0326dy_-CzM'},
      {'name': 'Hammer Curls', 'url': 'https://www.youtube.com/watch?v=zC3nLlEvin4'},
    ],
    'Chest & Shoulders': [
      {'name': 'Push-ups', 'url': 'https://www.youtube.com/watch?v=IODxDxX7oi4'},
      {'name': 'Bench Press', 'url': 'https://www.youtube.com/watch?v=gRVjAtPip0Y'},
      {'name': 'Shoulder Press', 'url': 'https://www.youtube.com/watch?v=qEwKCR5JCog'},
    ],
    'Back & Lats': [
      {'name': 'Pull-ups', 'url': 'https://www.youtube.com/watch?v=eGo4IYlbE5g'},
      {'name': 'Deadlifts', 'url': 'https://www.youtube.com/watch?v=op9kVnSso6Q'},
      {'name': 'Lat Pulldown', 'url': 'https://www.youtube.com/watch?v=CAwf7n6Luuc'},
    ],
    'Create Custom Plan': [
      {'name': '(Coming Soon)', 'url': ''},
    ],
  };

  void _launchVideo(String url) async {
    final Uri videoUri = Uri.parse(url);
    if (await canLaunchUrl(videoUri)) {
      await launchUrl(videoUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> exercises = workoutDetails[planName] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(planName),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return ListTile(
            title: Text(exercise['name']!),
            trailing: IconButton(
              icon: const Icon(Icons.play_circle_fill, color: Colors.redAccent),
              onPressed: () {
                if (exercise['url'] != null && exercise['url']!.isNotEmpty) {
                  _launchVideo(exercise['url']!);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
