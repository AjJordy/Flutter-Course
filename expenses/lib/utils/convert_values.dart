String convertValue(double value) {
  if (value > 1000) {
    return "R\$${value ~/ 1000}K";
  }
  return "R\$${value.toInt()}";
}
