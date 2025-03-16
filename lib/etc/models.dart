class Item {
  final int? id;
  final double lan;
  final double lon;
  final String date;
  final double temperature;

  Item({this.id, required this.lan, required this.lon, required this.date, required this.temperature});

  Map<String, dynamic> toMap() {
    return {'id': id, "lan": lan, "lon": lon, "date": date, "temperature": temperature};
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(id: map['id'], lan: map['lan'], lon: map['lon'], date: map['date'], temperature: map['temperature']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$id, $date, $lan, $lon, $temperature";
  }
}
