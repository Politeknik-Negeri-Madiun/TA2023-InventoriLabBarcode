class ProductModel {
  ProductModel({
    required this.code,
    required this.user,
    required this.name,
    required this.productId,
    required this.qty,
    required this.typ,
    required this.date,
  });

  final String code;
  final String user;
  final String name;
  final String productId;
  final int qty;
  final String typ;
  final String date;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"] ?? "",
        user: json["user"] ?? "",
        name: json["name"] ?? "",
        productId: json["productId"] ?? "",
        qty: json["qty"] ?? 0,
        typ: json["typ"] ?? "",
        date: json["date"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "user": user,
        "name": name,
        "productId": productId,
        "qty": qty,
        "typ": typ,
        "date": date,
      };
}
