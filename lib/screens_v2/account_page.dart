import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ticktick/login_page_v2.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? _imageFile;
  bool _isEditing = false;
  String _displayName = 'Seven';
  String _bio = '';
  final email = FirebaseAuth.instance.currentUser?.email ?? '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  void _saveChanges() {
    setState(() {
      _displayName = _nameController.text;
      _bio = _bioController.text;
      _isEditing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = _displayName;
    _bioController.text = _bio;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: textColor,
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.black12,
                backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null
                    ? Icon(Icons.person, size: 50, color: textColor)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.black,
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.person, 'Display Name', _displayName, _nameController, textColor),
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.email, 'Email Address', email, null, textColor),
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.info_outline, 'Short Bio', _bio, _bioController, textColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _isEditing ? _saveChanges : () {
                    setState(() => _isEditing = true);
                  },
                  icon: Icon(_isEditing ? Icons.check_circle_outline : Icons.edit, size: 20),
                  label: Text(_isEditing ? 'Save' : 'Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(140, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(
                            isDarkMode: false,
                            onThemeChanged: (value) {},
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.logout, size: 20),
                  label: const Text('Log Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(140, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon,
      String label,
      String value,
      [TextEditingController? controller,
        Color? textColor]
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 4),
              controller != null && _isEditing
                  ? TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: label,
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Colors.white12,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              )
                  : Text(value, style: TextStyle(color: textColor ?? Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
