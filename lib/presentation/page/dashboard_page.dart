import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:electrosphereinventory/config/session.dart';
import 'package:electrosphereinventory/presentation/page/history/history_page.dart';
import 'package:electrosphereinventory/presentation/page/inout/inout_page.dart';
import 'package:electrosphereinventory/presentation/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:electrosphereinventory/config/app_color.dart';
import '../controller/c_user.dart';
import 'package:electrosphereinventory/presentation/controller/c_dashboard.dart';
import 'package:electrosphereinventory/presentation/page/product/product_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final cUser = Get.put(CUser());
  final cDashboard = Get.put(CDashboard());

logout() async {
  bool yes = await DInfo.dialogConfirmation(
    context,
    'Logout',
    'Are you sure to logout?',
  )?? false;
  if (yes) {
    Session.clearUser();
    Get.off(() => const LoginPage());
  }
}

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () => logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileCard(textTheme),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DView.textTitle('Menu'),
            ),
            
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 120, // Tinggi setiap item
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: [
                menuProduct(textTheme),
                menuHistory(textTheme),
                menuIn(textTheme),
                menuOut(textTheme),
                Obx(
                  () {
                    if (cUser.data.level == 'Admin') {
                      return menuEmployee(textTheme);
                    } else {
                      return const SizedBox();
                    }
                  }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuProduct(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductPage())
        ?.then((value) => cDashboard.setProduct);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product',
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                  cDashboard.product.toString(),
                  style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  ),
                  );
                }),
                DView.width(8),
                const Text(
                  'Item',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuHistory(TextTheme textTheme) {
    return GestureDetector(
      onTap: (){
        Get.to(() => const HistoryPage())
        ?.then((value) => cDashboard.setHistory());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'History',
            style: textTheme.titleLarge,
          ),
          Row(
            children: [
              Obx((){
                return Text(
                cDashboard.history.toString(),
                style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
                );
              }),
              DView.width(8),
              const Text(
                'Act',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  
  }

  Widget menuIn(TextTheme textTheme) {
    return GestureDetector(
    onTap: (){
      Get.to(()=> const InOutPage(type: 'IN'))
        ?.then((value) => cDashboard.setIn());
    },
    child:Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.input,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IN',
            style: textTheme.titleLarge,
          ),
          Row(
            children: [
              Obx((){
                return Text(
                cDashboard.ins.toString(),
                style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
                );
              }),
              DView.width(8),
              const Text(
                'Item',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }

  Widget menuOut(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(()=> const InOutPage(type: 'OUT'))
            ?.then ((value)=> cDashboard.setOut());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OUT',
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Obx((){
                  return Text(
                  cDashboard.outs.toString(),
                  style: textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
                  );
                }),
                DView.width(8),
                const Text(
                  'Item',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container menuEmployee(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.input,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Employee',
            style: textTheme.titleLarge,
          ),
          Obx((){
            return Text(
              cDashboard.employee.toString(),
              style: textTheme.headlineMedium!.copyWith(
                color: Colors.white,
              ),
            );
          }),
        ],
      ),
    );
  }

  Container profileCard(TextTheme textTheme) {
    return Container(
      width: 450,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Text(
              cUser.data.name??'',
              style: textTheme.titleMedium,
            );
          }
          ),
          DView.height(4),
          Obx(() {
            return Text(
            cUser.data.email??'',
            style: textTheme.bodyMedium,
            );
          }
          
          ),
          DView.height(8),
          Obx((){
            return Text(
            '(${cUser.data.level})',
            style: textTheme.bodySmall,
            );
          }),
        ],
      ),
    );
  }
}