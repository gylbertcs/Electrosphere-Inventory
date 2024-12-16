import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:electrosphereinventory/data/model/product.dart';
import 'package:electrosphereinventory/data/source/source_product.dart';
import 'package:electrosphereinventory/presentation/page/product.dart/add_update_product_page.dart';
import 'package:flutter/material.dart';
import 'package:d_view/d_view.dart';
import 'package:electrosphereinventory/presentation/controller/c_product.dart';
import 'package:get/get.dart';

class PickProductPage extends StatefulWidget {
  const PickProductPage({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<PickProductPage> createState() => _PickProductPageState();
}

class _PickProductPageState extends State<PickProductPage> {
  final cProduct = Get.put(CProduct());

  pick(Product product) async{
    final controllerQuantity = TextEditingController();
     bool yes = await Get.dialog(
    AlertDialog(
    title: const Text('Quantity'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DInput(controller: controllerQuantity,hint:'50',
        inputType: TextInputType.number ,
        ),
        DView.spaceHeight(8),
        const Text('Yes to confirm'),
      ],
    ),
    actions: [
      TextButton(onPressed: () => Get.back(result: false), child: const Text('No'),),
      TextButton(onPressed: () {
        if (controllerQuantity.text =='') {
          DInfo.toastError("Quantity don't empty");
        } else {
          Get.back (result: true);
        }
      },
      child: const Text('Yes'),),
    ],
   ),barrierDismissible:false 
   );
   if(yes) {
      int stock = await SourceProduct.stock(product.code!);
   }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar (
        title: Text('Pick Product ${widget.type}'),
        titleSpacing: 0,
      
      ),
      body: Obx(() {
          if (cProduct.loading) return DView.loadingCircle();
          if (cProduct.list.isEmpty) return DView.empty();
          return ListView.separated(
            itemCount: cProduct.list.length,
            separatorBuilder: (context, index) {
              return const Divider(
              height: 1,
              color: Colors.white60,
              indent: 16,
              endIndent: 16,
              );
            },
            itemBuilder: (context, index) {
              Product product = cProduct.list[index];
              return GestureDetector(
                onTap: () {
                  pick(product);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 16 : 8,
                    0,
                    index == 9 ? 16 : 0,
                  ),
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(
                      height: 30,
                      width: 30,
                      child: Text('${index + 1}'),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          product.name??'',
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DView.spaceHeight(4),
                        Text(
                          product.code??'',
                          style: textTheme.titleSmall!.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        DView.spaceHeight(16), 
                        Text(
                          'Rp ${product.price??''}',
                          style: textTheme.titleSmall!.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                              product.stock.toString(),
                              style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                              ),
                            ),
                          DView.spaceHeight(4),
                          Padding(
                              padding: const EdgeInsets.only(right: 16),
                            child: Text(
                                product.unit??'',
                                style: textTheme.titleSmall!.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ],
                      ),
                    ],
                  ),
                ),
              ); 
            },
          );
        }
      )
    );
  }
}
