import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:electrosphereinventory/data/model/product.dart';
import 'package:electrosphereinventory/data/source/source_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUpdateProductPage extends StatefulWidget {
  const AddUpdateProductPage({super.key, this.product});
  final Product? product;

  @override
  State<AddUpdateProductPage> createState() => _AddUpdateProductPageState();
}

class _AddUpdateProductPageState extends State<AddUpdateProductPage> {
  final controllerCode = TextEditingController();
  final controllerName = TextEditingController();
  final controllerPrice = TextEditingController(); 
  final controllerStock = TextEditingController(); 
  final controllerUnit = TextEditingController();   
  final formKey = GlobalKey<FormState>();

  addProduct() async {
  bool? yes = await DInfo.dialogConfirmation(
    context,
      'Add Product',
      'Are you sure you want to add a new product?',
  );

    if (yes == true) {
      bool success = await SourceProduct.add(Product(
        code: controllerCode.text,
        name: controllerName.text,
        price: controllerPrice.text,
        stock: int.parse(controllerStock.text),
        unit: controllerUnit.text,
      ));

      if (success) {
        print('Success Add New Product');
        DInfo.dialogSuccess('Success Add New Product');
        DInfo.closeDialog(actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        print('Failed to add new product');
        DInfo.dialogError('Failed Add New Product');
        DInfo.closeDialog();
      }
    }  else {
      print('User canceled the dialog');
    }
  }

  updateProduct() async{
    bool? yes = await DInfo.dialogConfirmation(
      context,
        'Update Product',
        'Are you sure to update product?',
    );

      if (yes == true) {
        bool success = await SourceProduct.update(
          widget.product!.code!, //as old code
          Product(
          code: controllerCode.text, //as new code
          name: controllerName.text,
          price: controllerPrice.text,
          stock: int.parse(controllerStock.text),
          unit: controllerUnit.text,
        ));

        if (success) {
          print('Success Update Product');
          DInfo.dialogSuccess('Success Update Product');
          DInfo.closeDialog(actionAfterClose: () {
            Get.back(result: true);
          });
        } else {
          print('Failed Update Product');
          DInfo.dialogError('Failed Update Product');
          DInfo.closeDialog();
        }
      }  
    }
  

  @override
    void initState() {
      super.initState();
      if (widget.product != null) {
        controllerCode.text = widget.product?.code ??'';
        controllerName.text = widget.product?.name ??'';
        controllerStock.text = widget.product?.stock.toString() ?? '0';
        controllerUnit.text = widget.product?.unit ??'';
        controllerPrice.text = widget.product?.price ??''; 
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        DView.appBarLeft(widget.product==null? 'Add Product':'Update Product'),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              controller: controllerCode,
            hint: 'JAG5676',
            title: 'Code',
            validator: (value)=>value==''?"Dont't Empty":null,
            isRequired: true,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerName,
            hint: 'Your Name',
            title: 'Name',
            validator: (value)=>value==''?"Dont't Empty":null,
            isRequired: true,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerPrice,
            hint: '2000000',
            title: 'Price',
            validator: (value)=>value==''?"Dont't Empty":null,
            isRequired: true,
            inputType: TextInputType.number,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerStock,
            hint: '50',
            title: 'Stock',
            validator: (value)=>value==''?"Dont't Empty":null,
            isRequired: true,
            inputType: TextInputType.number,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerUnit,
            hint: 'Item',
            title: 'Unit',
            validator: (value)=>value==''?"Dont't Empty":null,
            isRequired: true,
            ),
            DView.spaceHeight(),
            ElevatedButton(
              onPressed: (){
                if(formKey.currentState!.validate()){
                  if(widget.product==null) {
                    addProduct();
                  } else {
                    updateProduct();
                  }
                }
              }, 
              child: Text(widget.product==null? 'Add Product':'Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}