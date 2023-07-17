class ProductModel {
  ProductModel({
    required this.code,
    required this.user,
    required this.uid,
    required this.name,
    required this.productId,
    required this.qty,
    required this.jml,
    required this.typ,
    required this.mtk,
    required this.ket,
    required this.date,
  });

  final String code;
  final String user;
  final String uid;
  final String name;
  final String productId;
  final int qty;
  final int jml;
  final String typ;
  final String mtk;
  final String ket;
  final String date;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"] ?? "",
        user: json["user"] ?? "",
        uid: json["uid"] ?? "",
        name: json["name"] ?? "",
        productId: json["productId"] ?? "",
        qty: json["qty"] ?? 0,
        jml: json["jml"] ?? 0,
        typ: json["typ"] ?? "",
        mtk: json["mtk"] ?? "",
        ket: json["ket"] ?? "",
        date: json["date"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "user": user,
        "uid": uid,
        "name": name,
        "productId": productId,
        "qty": qty,
        "jml": jml,
        "typ": typ,
        "mtk": mtk,
        "ket": ket,
        "date": date,
      };
}
