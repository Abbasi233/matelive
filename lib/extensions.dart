extension DateToString on DateTime {
  String formatWithMonthName() {
    List<String> _months = [
      "Ocak",
      "Şubat",
      "Mart",
      "Nisan",
      "Mayıs",
      "Haziran",
      "Temmuz",
      "Ağustos",
      "Eylül",
      "Ekim",
      "Kasım",
      "Aralık"
    ];
    try {
      return "${this.day.toString().padLeft(2, '0')} ${_months[this.month]} ${this.year} ${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return null;
    }
  }

  String formatToString() {
    try {
      return "${this.day.toString().padLeft(2, '0')}/${this.month.toString().padLeft(2, '0')}/${this.year}";
    } catch (e) {
      return null;
    }
  }
}

extension StringToDate on String {
  DateTime formatToDate() {
    var items = this.split("/");
    return DateTime(
        int.parse(items[2]), int.parse(items[1]), int.parse(items[0]));
  }
}
