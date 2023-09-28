abstract class TableObj<T> {
  List<T> columns = [];
  List<T> headers = [];

  void loadColumn();
  void loadHeader();
}

class TableData extends TableObj<String> {
  TableData() {
    loadColumn();
    loadHeader();
  }

  @override
  void loadColumn() {
    columns.addAll(List<String>.generate(30, (index) => 'Seat ${index + 1}'));
  }

  @override
  void loadHeader() {
    addTime(DateTime(0, 0, 0, 0, 0, 0));
  }

  void addTime(DateTime dt) {
    if (dt.hour == 23 && dt.minute == 5) return;
    int h = dt.hour + 1;
    String hour = '${h < 10 ? '0$h' : h}';
    String minute = '${dt.minute < 10 ? '0${dt.minute}' : dt.minute}';
    headers.add('$hour:$minute');
    addTime(dt.add(const Duration(minutes: 5)));
  }
}
