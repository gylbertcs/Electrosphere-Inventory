import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:electrosphereinventory/data/model/product.dart';
import 'package:electrosphereinventory/data/source/source_product.dart';

class CProduct extends GetxController {
        final RxBool _loading = false.obs;
        bool get loading =>_loading.value;
        set loading(bool newData) {
          _loading.value = newData;
        }

        final RxList<Product> _list = <Product>[].obs;
        List<Product> get list => _list.toList();
        setList() async {
          loading = true;
          _list.value = await SourceProduct.gets();
          Future.delayed(const Duration(seconds: 1),(){
          loading = false;
        });
      } 

    Future<void> deleteProduct(String code) async {
        bool? yes = await Get.defaultDialog<bool>(
          title: 'Delete Product',
          middleText: 'Are you sure you want to delete this product?',
          confirm: ElevatedButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text('Yes'),
          ),
          cancel: ElevatedButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text('No'),
          ),
        );

        if (yes == true) {
      // Call the delete method on your data source here
      await SourceProduct.delete(code);
      // Remove the product from the list after successful deletion
      _list.removeWhere((product) => product.code == code);
      DInfo.dialogSuccess('Product deleted successfully!');
    }
  
      }
    
      @override
      void onInit() {
        setList();
        super.onInit();
      }
}


