import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/admin_status_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barcode_ta/app/data/models/product_model.dart';
import 'package:barcode_ta/app/routes/app_pages.dart';

class AdminStatusView extends GetView<AdminStatusController> {
  AdminStatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminStatusController());
    Size size = MediaQuery.of(context).size;
    final searchC = TextEditingController();
    List<ProductModel> allProductsMain = [];
    var allProducts = <ProductModel>[].obs;

    onSearch(String key) {
      if (key.isEmpty) {
        // Jika key kosong, tampilkan semua data yang ada
        allProducts.value = allProductsMain.toList();
      } else {
        allProducts.value = allProductsMain
            .where((data) => data.user
                .toString()
                .toLowerCase()
                .contains(key.toString().toLowerCase()))
            .toList();
      }
    }

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
                  "Status Barang",
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextField(
                      controller: searchC,
                      onChanged: (value) => onSearch(value),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(70),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        hintText: "Search",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        suffixIcon: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () {},
                          child: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 270),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: Get.put(AdminStatusController()).streamStatusBarang(),
                  builder: (context, snapProducts) {
                    if (snapProducts.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapProducts.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No Products"),
                      );
                    }

                    allProductsMain
                        .clear(); // Reset allProductsMain sebelum mengisi ulang data
                    for (var element in snapProducts.data!.docs) {
                      allProductsMain.add(
                        ProductModel.fromJson(
                          element.data(),
                        ),
                      );
                    }
                    controller.allProducts
                        .removeWhere((data) => !allProductsMain.contains(data));
                    controller.allProducts.refresh();

                    allProducts.value = allProductsMain
                        .where((data) => data.user
                            .toString()
                            .toLowerCase()
                            .contains(searchC.text))
                        .toList();

                    return Obx(() {
                      if (allProducts.isEmpty) {
                        return Center(
                          child: Text('TIDAK ADA DATA'),
                        );
                      } else {
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
                                  Get.toNamed(Routes.DETAIL_BARANG,
                                      arguments: product);
                                },
                                borderRadius: BorderRadius.circular(9),
                                child: Container(
                                  height: 190,
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.code,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              product.user,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
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
                      }
                    });
                  }),
            ),
            Positioned(
              bottom: 0,
              left: 25,
              child: GestureDetector(
                onTap: () {
                  controller.downloadCatalog();
                },
                child: Image.asset(
                  "assets/icons/catalog.png",
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
