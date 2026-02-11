extension StringUtils on String {
  String capitalizeAll() {
    String temp = split(' ').map((word) => word.capitalize()).join(' ');
    temp = temp.split('-').map((word) => word.capitalize()).join('-');
    return temp;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
