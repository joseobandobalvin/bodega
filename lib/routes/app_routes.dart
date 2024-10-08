import 'package:bodega/controllers/home_controller.dart';
import 'package:bodega/controllers/product_controller.dart';
import 'package:bodega/controllers/settings_controller.dart';
import 'package:bodega/screens/detail/detail_product_screen.dart';
import 'package:bodega/screens/home/home_screen.dart';
import 'package:bodega/screens/product/edit_new_product_screen.dart';
import 'package:bodega/screens/product/list_product_screen.dart';
import 'package:bodega/screens/product/search_product_screen.dart';
import 'package:bodega/screens/settings/settings_screen.dart';

import 'package:get/get.dart';

class AppRoutes {
  static const String splashPage = "/splash";
  static const String homePage = "/";
  static const String loginPage = "/login";

  static const String cardDetailPage = "/card-detail";
  static const String organizationFilterPage = "/organization-filter";

  static const String product = "/product";
  static const String searchProduct = "/search-product";
  static const String newProduct = "/new-product";
  static const String detailProduct = "/detail-product";

  static const String settings = "/settings";

  static List<GetPage> routes() => [
        // GetPage(
        //   name: splashPage,
        //   page: () => const SplashScreen(),
        //   binding: BindingsBuilder(() {
        //     Get.put(SplashController());
        //   }),
        // ),
        GetPage(
          name: homePage,
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            //Get.put(AuthController());
            Get.put(HomeController());
            //Get.put(MyZoomDrawerController());
          }),
        ),
        // GetPage(
        //   name: loginPage,
        //   page: () => const LoginScreen(),
        //   binding: BindingsBuilder(() {
        //     Get.put(AuthController());
        //     Get.put(MyZoomDrawerController());
        //   }),
        // ),
        GetPage(
          name: product,
          page: () => const ListProductScreen(),
          binding: BindingsBuilder(() {
            //Get.put(ProductController());
          }),
        ),
        GetPage(
          name: newProduct,
          page: () => EditNewProductScreen(),
          binding: BindingsBuilder(() {
            Get.put(ProductController());
          }),
        ),
        GetPage(
          name: detailProduct,
          page: () => DetailProductScreen(),
          binding: BindingsBuilder(() {
            Get.put(ProductController());
          }),
        ),
        // GetPage(
        //   name: organizationFilterPage,
        //   page: () => const OrganizationFilterScreen(),
        //   binding: BindingsBuilder(() {
        //     Get.put(OrganizationController());
        //   }),
        // ),
        GetPage(
          name: searchProduct,
          page: () => const SearchProductScreen(),
          binding: BindingsBuilder(() {
            Get.put(ProductController());
          }),
        ),

        GetPage(
          name: settings,
          page: () => const SettingsScreen(),
          binding: BindingsBuilder(() {
            Get.put(SettingsController());
          }),
        ),
      ];
}
