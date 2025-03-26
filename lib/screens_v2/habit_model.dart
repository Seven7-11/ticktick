class Habit {
  final String name;
  final String unit;
  final double total;
  double progress;

  Habit({
    required this.name,
    required this.unit,
    required this.total,
    this.progress = 0.0,
  });
}
