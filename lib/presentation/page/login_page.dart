import 'package:d_view/d_view.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:electrosphereinventory/config/app_color.dart';
import 'package:electrosphereinventory/data/source/source_user.dart';
import 'package:electrosphereinventory/presentation/page/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  void login() async {
    bool success = await SourceUser.login(
      controllerEmail.text,
      controllerPassword.text,
    );
    if (success){
      DInfo.dialogSuccess('Login Success');
      DInfo.closeDialog(actionAfterClose: (){
        Get.off(() => const DashboardPage());
      });
    } else {
      DInfo.dialogError('Login Failed');
    }
    DInfo.closeDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, boxConstraints) {
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
                        DView.height(MediaQuery.of(context).size.height * 0.15),
                        Text(
                          'Electrosphere\nInventory',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        DView.height(8),
                        Container(
                          height: 6,
                          width: 160,
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        DView.height(MediaQuery.of(context).size.height * 0.15),
                      ],
                    ),
                    Column(
                      children: [
                        input(controllerEmail, Icons.email, 'Email'),
                        DView.height(),
                        input(controllerPassword, Icons.vpn_key, 'Password', true),
                        DView.height(),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => login(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    
                        DView.height(MediaQuery.of(context).size.height * 0.15),
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
