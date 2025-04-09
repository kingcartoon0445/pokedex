class NumberFormatter {
  static String formatDouble(double number) {
    double n = number / 10;
    return n.toString(); //.padLeft(3, '0');
  }

  static String format(int number) {
    return "Nº${number.toString().padLeft(3, '0')}";
  }
}
