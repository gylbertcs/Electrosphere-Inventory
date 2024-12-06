import 'package:d_view/d_view.dart';
import 'package:electrosphereinventory/config/app_color.dart';
import 'package:electrosphereinventory/presentation/controller/c_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:get/get_core/src/get_main.dart';

import '../../../data/model/history.dart';
import '../../controller/c_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final cHistory = Get.put(CHistory());
  final controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const Text('History'),
            //DView.spaceWidth(16),
            search(),
          ],
        ),
      ),

      body: GetBuilder<CHistory>(
        builder: (_) {
          if(cHistory.list.isEmpty) return DView.empty();
          return ListView(
            children: [
              ...List.generate(cHistory.list.length, (index) {
                History history = cHistory.list[index];
                return Column(
                  children: [
                    ListTile(
                      leading: history.type == 'IN'
                      ? const Icon(Icons.south_west, color: Colors.green)
                      : const Icon(Icons.north_east, color: Colors.red),
                      horizontalTitleGap: 0,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(history.listProduct??"",
                          style: Theme.of(context). textTheme.bodyLarge,
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            history.createdAt??"",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            'Rp ${history.totalPrice}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                        ],
                      )
                       
                      
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.white54,
                      indent: 16,
                      endIndent: 16,
                      ),
          
                  ],
                );
              }),
              if(cHistory.hasNext)
              cHistory.fetchData?DView.loadingCircle():
                Center(
                  child: IconButton(
                    onPressed: () => cHistory.getList(),
                    icon: const Icon(Icons.refresh),
                  ),
                ),
            ],
          );
        }
      ),
    );
  }

  Expanded search() {
    return Expanded(
            child: Container(
              height: 70,
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: controllerSearch,
                onTap: () async {
                  DateTime? result = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate:
                      DateTime.now()
                        .add(const Duration(days: 30)),

                  );
                  if(result != null) {
                    controllerSearch.text = DateFormat('yyyy-MM-dd').format(result);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  isDense: true,
                  filled: true,
                  fillColor: AppColor.input,
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (controllerSearch.text != '') {
                        cHistory.search(controllerSearch.text);
                      }
                    },
                    icon: const Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
            ),
          );
  }
}

