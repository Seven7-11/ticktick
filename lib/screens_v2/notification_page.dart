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
        title: const Text("ยืนยันการลบ"),
        content: Text("คุณแน่ใจหรือไม่ที่จะลบ ${_items[index].title}?"),
        actions: [
          TextButton(
            child: const Text("ยกเลิก"),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: const Text("ลบ"),
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
          title: const Text('เพิ่มกิจกรรม'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(labelText: 'ชื่อกิจกรรม'),
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
                label: const Text("เลือกเวลา"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก'),
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
              child: const Text('เพิ่ม'),
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
