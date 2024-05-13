String convertValue(double value) {
  if (value > 1000) {
    return "R\$${value ~/ 1000}K";
  }
  return "R\$${value.toInt()}";
}

String convertValueSmall(double value) {
  if (value > 1000) {
    return "${value ~/ 1000}K";
  }
  return "${value.toInt()}";
}
