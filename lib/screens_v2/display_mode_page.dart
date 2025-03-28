import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayModePage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const DisplayModePage({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<DisplayModePage> createState() => _DisplayModePageState();
}

class _DisplayModePageState extends State<DisplayModePage> {
  late bool _selectedDarkMode;

  @override
  void initState() {
    super.initState();
    _loadThemePref();
  }

  void _loadThemePref() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool("isDarkMode");

    if (isDark != null) {
      setState(() {
        _selectedDarkMode = isDark;
      });
    }
  }

  void _updateTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", isDark);
    debugPrint("isDark \$isDark");
    widget.onThemeChanged(isDark);
    setState(() {
      _selectedDarkMode = isDark;
    });
  }

  Widget _buildModeButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 90, //
        padding: const EdgeInsets.symmetric(vertical: 12), //
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: isSelected ? Colors.amber : Colors.grey),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? Colors.amber : Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Icon(
              Icons.check_circle,
              size: 14,
              color: isSelected ? Colors.amber : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display mode"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildModeButton(
              icon: Icons.nightlight_round,
              label: 'Dark',
              isSelected: _selectedDarkMode,
              onTap: () => _updateTheme(true),
            ),
            const SizedBox(width: 20),
            _buildModeButton(
              icon: Icons.wb_sunny,
              label: 'Light',
              isSelected: !_selectedDarkMode,
              onTap: () => _updateTheme(false),
            ),
          ],
        ),
      ),
    );
  }
}
