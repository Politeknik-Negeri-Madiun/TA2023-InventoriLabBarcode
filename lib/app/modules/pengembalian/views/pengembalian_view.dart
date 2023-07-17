import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/pengembalian_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barcode_ta/app/data/models/product_model.dart';
import 'package:barcode_ta/app/routes/app_pages.dart';

class PengembalianView extends GetView<PengembalianController> {
  const PengembalianView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/logo/ellipse1.png",
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/logo/ellipse2.png",
                width: size.width * 0.3,
              ),
            ),
            ListView(
              padding: EdgeInsets.all(20),
              children: [
                Image.asset(
                  "assets/logo/logo2.png",
                  height: 110,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Pengembalian Barang",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                  width: 150.0,
                  child: Divider(
                    color: Color.fromARGB(255, 6, 28, 26),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 185),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: Get.put(PengembalianController()).streamStatusBarang(),
                builder: (context, snapProducts) {
                  if (snapProducts.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapProducts.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No Products"),
                    );
                  }

                  List<ProductModel> allProducts = [];

                  for (var element in snapProducts.data!.docs) {
                    allProducts.add(
                      ProductModel.fromJson(
                        element.data(),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: allProducts.length,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, Index) {
                      ProductModel product = allProducts[Index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.only(bottom: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_HISTORY,
                                arguments: product);
                          },
                          borderRadius: BorderRadius.circular(9),
                          child: Container(
                            height: 110,
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ("Product Code : ${product.code}"),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(product.name),
                                      Text("JUMLAH : ${product.qty}"),
                                      Text(product.typ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "${DateFormat.yMd().add_Hms().format(DateTime.parse(product.date))}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: QrImageView(
                                    data: product.code,
                                    size: 200.0,
                                    version: QrVersions.auto,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
