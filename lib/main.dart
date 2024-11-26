import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:electrosphereinventory/config/app_color.dart';
import 'package:electrosphereinventory/config/session.dart';
import 'presentation/controller/c_user.dart';
import 'presentation/page/dashboard_page.dart';
import 'presentation/page/login_page.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Session.getUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primary,
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColor.primary,
        ),
      ),
      home: Obx(() {
        if (cUser.data.idUser == null) return const LoginPage();
        return const DashboardPage();
      }),
    );
  }
}