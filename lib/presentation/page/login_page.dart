import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:electrosphereinventory/config/app_color.dart';
import 'package:electrosphereinventory/data/source/source_user.dart';
import 'package:electrosphereinventory/presentation/page/dashboard_page.dart';

import '../controller/c_user.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final cUser = Get.put(CUser());

  void login() async {
    bool success = await SourceUser.login(
      controllerEmail.text,
      controllerPassword.text,
    );
    if (success) {
      DInfo.dialogSuccess('Login Success');
      DInfo.closeDialog(actionAfterClose: () {
        DMethod.printTitle('Level User', cUser.data.level ?? '');
        if (cUser.data.level == 'Employee' &&
            controllerPassword.text == '123456') {
          changePassword();
        } else {
          Get.off(() => const DashboardPage());
        }
      });
    } else {
      DInfo.dialogError('Login failed');
      DInfo.closeDialog();
    }
  }

  changePassword() async {
    final controller = TextEditingController();
    bool yes = await Get.dialog(
      AlertDialog(
        title: const Text('Have to Change Password'),
        content: DInput(
          controller: controller,
          title: 'New Password',
          hint: 'nahgsy87',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Change'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    if (yes) {
      bool success = await SourceUser.changePassword(
        cUser.data.idUser.toString(),
        controller.text,
      );
      if (success) {
        DInfo.dialogSuccess('Change Password Success');
        DInfo.closeDialog(actionAfterClose: () {
          Get.off(() => const DashboardPage());
        });
      } else {
        DInfo.dialogError('Change Password Failed');
        DInfo.closeDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: boxConstraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DView.spaceHeight(
                        MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text(
                        'Inventory\nCourse',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      DView.spaceHeight(8),
                      Container(
                        height: 6,
                        width: 160,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      DView.spaceHeight(
                        MediaQuery.of(context).size.height * 0.15,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      input(controllerEmail, Icons.email, 'Email'),
                      DView.spaceHeight(),
                      input(
                          controllerPassword, Icons.vpn_key, 'Password', true),
                      DView.spaceHeight(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => login(),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DView.spaceHeight(
                        MediaQuery.of(context).size.height * 0.15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget input(
    TextEditingController controller,
    IconData icon,
    String hint, [
    bool obsecure = false,
  ]) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: AppColor.input,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
        prefixIcon: Icon(icon, color: AppColor.primary),
        hintText: hint,
      ),
      obscureText: obsecure,
    );
  }
}
