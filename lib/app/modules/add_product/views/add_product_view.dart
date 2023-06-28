import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  final addC = Get.put(AddProductController(), permanent: true);
  AddProductView({Key? key}) : super(key: key);
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  final TextEditingController typC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD PRODUCT'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "product code",
              labelText: "Product Code",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "product name",
              labelText: "Product Name",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: qtyC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "quantity",
              labelText: "Quantity",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButtonFormField(
            value: typC.text.isEmpty ? null : typC.text,
            onChanged: (newValue) {
              // Tambahkan kode untuk mengubah nilai pada controller hanya ketika ada item yang dipilih
              if (newValue != null) {
                typC.text = newValue.toString();
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Select type",
              labelText: "Type",
            ),
            items: [
              DropdownMenuItem(
                value: "BHP",
                child: Text("BHP"),
              ),
              DropdownMenuItem(
                value: "BMN",
                child: Text("BMN"),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (codeC.text.isNotEmpty &&
                    nameC.text.isNotEmpty &&
                    qtyC.text.isNotEmpty &&
                    typC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> hasil = await controller.addProduct({
                    "code": codeC.text,
                    "name": nameC.text,
                    "qty": int.tryParse(qtyC.text) ?? 0,
                    "typ": typC.text,
                  });
                  controller.isLoading(false);

                  Get.back();

                  Get.snackbar(hasil["error"] == true ? "Error" : "Success",
                      hasil["message"]);
                } else {
                  Get.snackbar("Error", "Semua data wajib diisi.");
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () => Text(
                  controller.isLoading.isFalse ? "ADD PRODUCT" : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
