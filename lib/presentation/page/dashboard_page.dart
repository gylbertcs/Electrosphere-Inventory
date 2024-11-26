import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:electrosphereinventory/config/app_color.dart';
import '../controller/c_user.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {},
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

  Container menuProduct(TextTheme textTheme) {
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
            'Product',
            style: textTheme.titleLarge,
          ),
          Row(
            children: [
              Text(
                '100',
                style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
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
    );
  }

  Container menuHistory(TextTheme textTheme) {
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
            'History',
            style: textTheme.titleLarge,
          ),
          Row(
            children: [
              Text(
                '100',
                style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
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
    );
  }

  Container menuIn(TextTheme textTheme) {
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
            'IN',
            style: textTheme.titleLarge,
          ),
          Row(
            children: [
              Text(
                '100',
                style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
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
    );
  }

  Container menuOut(TextTheme textTheme) {
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
            'OUT',
            style: textTheme.titleLarge,
          ),
          Row(
            children: [
              Text(
                '100',
                style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
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
          Text(
            '100',
            style: textTheme.headlineMedium!.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Container profileCard(TextTheme textTheme) {
    return Container(
      width: 350,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: textTheme.titleMedium,
          ),
          DView.height(4),
          Text(
            'Email',
            style: textTheme.bodyMedium,
          ),
          DView.height(8),
          Text(
            '(Admin)',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}