import 'package:get/get.dart';

import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/admin_pengembalian/bindings/admin_pengembalian_binding.dart';
import '../modules/admin_pengembalian/views/admin_pengembalian_view.dart';
import '../modules/admin_status/bindings/admin_status_binding.dart';
import '../modules/admin_status/views/admin_status_view.dart';
import '../modules/detail_barang/bindings/detail_barang_binding.dart';
import '../modules/detail_barang/views/detail_barang_view.dart';
import '../modules/detail_history/bindings/detail_history_binding.dart';
import '../modules/detail_history/views/detail_history_view.dart';
import '../modules/detail_product/bindings/detail_product_binding.dart';
import '../modules/detail_product/views/detail_product_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupa_password/bindings/lupa_password_binding.dart';
import '../modules/lupa_password/views/lupa_password_view.dart';
import '../modules/peminjaman_barang/bindings/peminjaman_barang_binding.dart';
import '../modules/peminjaman_barang/views/peminjaman_barang_view.dart';
import '../modules/pengembalian/bindings/pengembalian_binding.dart';
import '../modules/pengembalian/views/pengembalian_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/scan_peminjam/bindings/scan_peminjam_binding.dart';
import '../modules/scan_peminjam/views/scan_peminjam_view.dart';
import '../modules/status/bindings/status_binding.dart';
import '../modules/status/views/status_view.dart';
import '../modules/stok_barang/bindings/stok_barang_binding.dart';
import '../modules/stok_barang/views/stok_barang_view.dart';
import '../modules/update_password/bindings/update_password_binding.dart';
import '../modules/update_password/views/update_password_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PEMINJAMAN_BARANG,
      page: () => Peminjaman_BarangView(),
      binding: PeminjamanBarangBinding(),
    ),
    GetPage(
      name: _Paths.STOK_BARANG,
      page: () => Stok_BarangView(),
      binding: StokBarangBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_PEMINJAM,
      page: () => Scan_PeminjamView(),
      binding: ScanPeminjamBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.STATUS,
      page: () => StatusView(),
      binding: StatusBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT,
      page: () => DetailProductView(),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_BARANG,
      page: () => DetailBarangView(),
      binding: DetailBarangBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_STATUS,
      page: () => AdminStatusView(),
      binding: AdminStatusBinding(),
    ),
    GetPage(
      name: _Paths.PENGEMBALIAN,
      page: () => const PengembalianView(),
      binding: PengembalianBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HISTORY,
      page: () => DetailHistoryView(),
      binding: DetailHistoryBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PENGEMBALIAN,
      page: () => const AdminPengembalianView(),
      binding: AdminPengembalianBinding(),
    ),
  ];
}
