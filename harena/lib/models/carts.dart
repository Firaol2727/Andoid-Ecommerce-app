class CartData {
  int cartid;
  int pid;
  String pname;
  String description;
  double price;
  double markerPrice;
  int letmeSee;
  int SellerSid;
  late List<String> pictures;
  CartData(
      {required this.cartid,
      required this.pid,
      required this.pname,
      required this.description,
      required this.price,
      required this.markerPrice,
      required this.letmeSee,
      required this.SellerSid});
}
