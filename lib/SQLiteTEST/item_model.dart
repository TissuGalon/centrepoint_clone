final String tableItem = 'items';
final String columnId = '_id';
final String columnName = 'name';

class Item {
  int? id;
  String name;

  Item({this.id, required this.name});

  // Konversi Item ke Map
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // Konversi Map ke Item
  Item.fromMap(Map<String, Object?> map) : name = map[columnName] as String {
    // Inisialisasi 'name' disini
    id = map[columnId] as int?;
  }
}
