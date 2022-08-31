extension StringX on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";

  String toTitleCase() => split(" ").map((word) => word.capitalize()).join(" ");

  int toInt() => int.tryParse(this) ?? 0;
}
