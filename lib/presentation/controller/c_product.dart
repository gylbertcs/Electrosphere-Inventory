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
        List<Product> get list => _list.value;
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
      }
    
      @override
      void onInit() {
        setList();
        super.onInit();
      }
}


