import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:electrosphereinventory/data/model/history.dart';
import 'package:electrosphereinventory/data/source/source_inout.dart';
import 'package:electrosphereinventory/presentation/controller/c_add_inout.dart';
import 'package:electrosphereinventory/presentation/page/inout/pick_product_page.dart';
import 'package:flutter/material.dart';
import 'package:d_view/d_view.dart';
import 'package:get/get.dart';
import '../../controller/c_add_inout.dart';
import '../../controller/c_detail_history.dart';


class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage({Key? key, required this.idhHistory}) : super(key: key);
  final String idhHistory;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final cDetailHistory = Get.put(CDetailHistory());
  @override
  void initState() {
    cDetailHistory.setData(widget.idhHistory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:Obx(
           () {
              if(cDetailHistory.data.idHistory==null) return const Text ('');
            return Text(cDetailHistory.data.createdAt ?? "");
          }
        ),
        actions: [
         Obx(
           () {
            if (cDetailHistory.data.type ==null) return const SizedBox();
             return  cDetailHistory.data.type == 'IN'
                      ? const Icon(Icons.south_west, color: Colors.green)
                      : const Icon(Icons.north_east, color: Colors.red);
           }
         ),
         DView.spaceWidth(),
        ],
      ),
      body: ListView(
        children: [
          GetBuilder<CDetailHistory>(
            builder: (_) {
              if(cDetailHistory.data.idHistory==null) return DView.empty();
              List listProduct = jsonDecode(cDetailHistory.data.listProduct!);
              if (listProduct.isEmpty) return DView.empty();
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listProduct.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    color: Colors.white60,
                    indent: 16,
                    endIndent: 16,
                  );
                },
                itemBuilder: (context, index) {
                  Map product = list[index];
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
                double totalPrice = double.parse(cDetailHistory.data.totalPrice?? '0'); 
                return Text(
                  'Rp ${totalPrice.toStringAsFixed(2)}' ,
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
