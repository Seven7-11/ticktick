
import 'package:flutter/material.dart';

class CreateCustomPlanPage extends StatefulWidget {
  @override
  _CreateCustomPlanPageState createState() => _CreateCustomPlanPageState();
}

class _CreateCustomPlanPageState extends State<CreateCustomPlanPage> {
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _customExerciseController = TextEditingController();
  final List<String> predefinedExercises = [
    'Push ups',
    'Squats',
    'Plank',
    'Jumping Jacks',
    'Lunges',
    'Crunches',
  ];

  final Map<String, bool> selectedExercises = {};
  final List<String> customExercises = [];

  @override
  void initState() {
    super.initState();
    for (var ex in predefinedExercises) {
      selectedExercises[ex] = false;
    }
  }

  void _addCustomExercise() {
    final name = _customExerciseController.text.trim();
    if (name.isNotEmpty && !selectedExercises.containsKey(name)) {
      setState(() {
        selectedExercises[name] = true;
        customExercises.add(name);
        _customExerciseController.clear();
      });
    }
  }

  void _savePlan() {
    final name = _planNameController.text.trim();
    if (name.isEmpty) return;

    final selected = selectedExercises.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selected.isEmpty) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('✅ Plan Saved!'),
        content: Text('Plan "$name" saved with ${selected.length} exercises.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildExerciseList() {
    return Column(
      children: selectedExercises.entries.map((entry) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: CheckboxListTile(
            title: Text(entry.key),
            value: entry.value,
            onChanged: (val) {
              setState(() {
                selectedExercises[entry.key] = val ?? false;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Custom Plan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle("ชื่อแผน"),
            TextField(
              controller: _planNameController,
              decoration: InputDecoration(
                hintText: 'เช่น My Leg Day',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            _buildTitle("เลือกท่าฝึก"),
            _buildExerciseList(),
            const Divider(height: 30),
            _buildTitle("เพิ่มท่าเอง"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customExerciseController,
                    decoration: InputDecoration(
                      hintText: 'พิมพ์ชื่อท่าใหม่',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.purple, size: 30),
                  onPressed: _addCustomExercise,
                )
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                icon: const Icon(Icons.save),
                label: const Text('Save Plan'),
                onPressed: _savePlan,
              ),
            )
          ],
        ),
      ),
    );
  }
}
