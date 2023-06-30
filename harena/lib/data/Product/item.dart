import 'dart:ffi';

class Item {
  String id;
  String name;
  String size;
  String type;
  String adtype;
  var imageList = <String>[];
  double price;
  dynamic colors;
  String description;
  String brand = '';
  String weight = '';
  String height = '';
  String material = '';
  Item(
      {required this.id,
      required this.price,
      required this.imageList,
      required this.type,
      this.adtype='img',
      this.colors,
      this.name = '',
      this.size = '',
      this.brand = '',
      this.weight = '',
      this.height = '',
      this.material = '',
      this.description = ''});
}
