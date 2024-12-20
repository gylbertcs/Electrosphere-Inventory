import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/source/source_user.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  add() async {
    if (formKey.currentState!.validate()) {
      bool? yes = await DInfo.dialogConfirmation(
          context, 'Add Employee', 'Yes to confirm');
      if (yes ?? false) {
        bool success = await SourceUser.add(
          controllerName.text,
          controllerEmail.text,
          controllerPassword.text,
        );
        if (success) {
          DInfo.dialogSuccess('Success Add Employee');
          DInfo.closeDialog(
            actionAfterClose: () => Get.back(result: true),
          );
        } else {
          DInfo.dialogError('Failed Add Employee');
          DInfo.closeDialog();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Add Employee'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              title: 'Name',
              controller: controllerName,
              validator: (value) => value == '' ? "Don't empty" : null,
            ),
            // ignore: deprecated_member_use
            DView.spaceHeight(),
            DInput(
              title: 'Email',
              controller: controllerEmail,
              validator: (value) => value == '' ? "Don't empty" : null,
            ),
            // ignore: deprecated_member_use
            DView.spaceHeight(),
            DInput(
              title: 'Password',
              controller: controllerPassword,
              validator: (value) => value == '' ? "Don't empty" : null,
            ),
            DView.height(),
            ElevatedButton(
              onPressed: () => add(),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
