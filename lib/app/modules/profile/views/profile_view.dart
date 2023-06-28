import 'package:barcode_ta/app/modules/profile/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ProfileView extends GetView<ProfileController> {
  final profileC = Get.put(ProfileController(), permanent: true);
  ProfileView({Key? key}) : super(key: key);
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
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.streamUser(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snap.hasData) {
                  Map<String, dynamic> user = snap.data!.data()!;
                  String defaultImage =
                      "https://ui-avatars.com/api/?name=${user['name']}";
                  return ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                user["profile"] != null
                                    ? user["profile"] != ""
                                        ? user["profile"]
                                        : defaultImage
                                    : defaultImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${user['name'].toString().toUpperCase()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Workshop Kerja Bangku & Pengelasan",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                        width: 150.0,
                        child: Divider(
                          color: Color.fromARGB(255, 6, 28, 26),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.teal,
                          ),
                          title: Text(
                            "${user['email']}",
                            style: TextStyle(
                                color: Colors.teal.shade100, fontSize: 20.0),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.teal,
                          ),
                          title: Text(
                            "${user['nohp']}",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.teal.shade100,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.assignment_ind_outlined,
                            color: Colors.teal,
                          ),
                          title: Text(
                            "${user['nim']}",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.teal.shade100,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        onTap: () =>
                            Get.toNamed(Routes.UPDATE_PROFILE, arguments: user),
                        leading: Icon(Icons.person),
                        title: Text("Update Profile"),
                      ),
                      ListTile(
                        onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                        leading: Icon(Icons.vpn_key),
                        title: Text("Update Password"),
                      ),
                      ListTile(
                        onTap: () => controller.logout(),
                        leading: Icon(Icons.logout),
                        title: Text("Logout"),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("Tidak dapat memuat data user."),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
