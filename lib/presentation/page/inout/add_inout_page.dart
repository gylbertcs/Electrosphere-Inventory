import 'package:d_info/d_info.dart';
import 'package:electrosphereinventory/data/source/source_inout.dart';
import 'package:electrosphereinventory/presentation/page/inout/pick_product_page.dart';
import 'package:flutter/material.dart';
import 'package:d_view/d_view.dart';
import 'package:get/get.dart';
import 'package:electrosphereinventory/presentation/controller/c_add_inout.dart';



class AddInOutPage extends StatefulWidget {
  const AddInOutPage({super.key, required this.type});
  final String type;

  @override
  State<AddInOutPage> createState() => _AddInOutPageState();
}

class _AddInOutPageState extends State<AddInOutPage> {

  final cAddInOut = Get.put(CAddInOut());
  
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Add ${widget.type}'),
        actions: [
          IconButton(
            onPressed: () async{ 
              bool? yes = await  DInfo.dialogConfirmation(context,'Confirmation Add', 'Yes to Confirm');
              if(yes == true) {
                cAddInOut.addInOut(widget.type); 
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => PickProductPage(type: widget.type))?.then((value) {
                  if (value != null) {
                    cAddInOut.add(value);
                  }
                });
              },
              child: const Text('Pick product'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: DView.textTitle('List Product'),
          ),
          const Divider(indent: 16, endIndent: 16),
          GetBuilder<CAddInOut>(
            builder: (_) {
              if (cAddInOut.list.isEmpty) return DView.empty();
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cAddInOut.list.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    color: Colors.white60,
                    indent: 16,
                    endIndent: 16,
                  );
                },
                itemBuilder: (context, index) {
                  Map product = cAddInOut.list[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      0,
                      index == 9 ? 16 : 0,
                    ),
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
                                product['name'],
                                style: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              DView.spaceHeight(4),
                              Text(
                                product['code'],
                                style: textTheme.titleSmall!.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                              DView.spaceHeight(16),
                              Text(
                                product['price'],
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
                                    product['quantity'],
                                    style: textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                DView.spaceHeight(4),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Text(
                                    product['unit'],
                                    style: textTheme.titleSmall!.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'delete') {
                                  // Logika untuk menghapus produk
                                  cAddInOut.delete(product);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ],
                              icon: const Icon(Icons.more_horiz),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          DView.spaceHeight(30),
          Center(child: Text('Total: ',style: textTheme.headlineMedium,)),
          Center(
            child: Obx(
               () {
                return Text('Rp ${cAddInOut.totalPrice.toStringAsFixed(2)}' ,
                style: textTheme.headlineSmall!.copyWith(
                  color: Colors.green,
                ),
                );
              }
            ),
            ),
          ],
        ),
      );
    }
  }
  