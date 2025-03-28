import 'package:flutter/material.dart';

class NotificationItem {
  String title;
  TimeOfDay time;
  bool isActive;

  NotificationItem({
    required this.title,
    required this.time,
    this.isActive = true,
  });
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationsPage> {
  List<NotificationItem> _items = [
    NotificationItem(title: "Run", time: TimeOfDay(hour: 10, minute: 30)),
    NotificationItem(title: "Gym", time: TimeOfDay(hour: 13, minute: 0)),
    NotificationItem(title: "Walk", time: TimeOfDay(hour: 5, minute: 30)),
  ];

  Future<void> _confirmDelete(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("! Warning"),
        content: Text("Are you sure you want to delete this activity?  ${_items[index].title}?"),
        actions: [
          TextButton(
            child: const Text("cancel"),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: const Text("Delete"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _items.removeAt(index);
      });
    }
  }

  void _showAddNotificationDialog() async {
    String newTitle = '';
    TimeOfDay selectedTime = TimeOfDay.now();

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Add Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Enter Habit'),
                onChanged: (value) {
                  newTitle = value;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (picked != null) {
                    selectedTime = picked;
                  }
                },
                icon: const Icon(Icons.access_time),
                label: const Text("Set Time"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newTitle.trim().isNotEmpty) {
                  setState(() {
                    _items.add(NotificationItem(title: newTitle, time: selectedTime));
                  });
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Activity", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (_, index) {
                  final item = _items[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (_) async {
                      await _confirmDelete(index);
                      return false;
                    },
                    child: Card(
                      color: Colors.black,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const Icon(Icons.directions_run, color: Colors.white),
                        title: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 30)),
                        subtitle: Text(
                          item.time.format(context),
                          style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                        trailing: Switch(
                          value: item.isActive,
                          onChanged: (value) {
                            setState(() {
                              item.isActive = value;
                            });
                          },
                          activeColor: Colors.amber,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: _showAddNotificationDialog,
      ),
    );
  }
}
