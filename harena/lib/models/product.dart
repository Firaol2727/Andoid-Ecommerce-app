class Product {
  int pid;
  String pname;
  String description;
  double price;
  double markerPrice;
  int letmeSee;
  int sellersid;
  late List<String> pictures;
  late String sellername;
  late String location;
  Product(
      {required this.pid,
      required this.pname,
      required this.description,
      required this.price,
      required this.markerPrice,
      required this.letmeSee,
      required this.sellersid,
      this.sellername = '',
      this.location = ''});
}
