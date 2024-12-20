import 'package:d_view/d_view.dart';
import 'package:electrosphereinventory/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:get/get_core/src/get_main.dart';

import '../../../data/model/history.dart';
import '../../controller/c_in_out_history.dart';
import '../history/detail_history_page.dart';
//import '../../controller/c_history.dart';

class InOutHistoryPage extends StatefulWidget {
  const InOutHistoryPage({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<InOutHistoryPage> createState() => _InOutHistoryPageState();
}

class _InOutHistoryPageState extends State<InOutHistoryPage> {
  final cInOutHistory = Get.put(CInOutHistory());
  final controllerSearch = TextEditingController();

  @override
  void initState() {
    cInOutHistory.getList(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Text('History ${widget.type}'),
            search(),
          ],
        ),
      ),
      body: GetBuilder<CInOutHistory>(builder: (_) {
        if (cInOutHistory.list.isEmpty) return DView.empty();
        return ListView(
          children: [
            ...List.generate(cInOutHistory.list.length, (index) {
              History history = cInOutHistory.list[index];
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(() => DetailHistoryPage(
                          idhHistory: '${history.idHistory}'))?.then((value) {
                        if (value ?? false) {
                          cInOutHistory.refreshData(widget.type);
                        }
                      });
                    },
                    leading: widget.type == 'IN'
                        ? const Icon(Icons.south_west, color: Colors.green)
                        : const Icon(Icons.north_east, color: Colors.red),
                    horizontalTitleGap: 0,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppFormat.date(history.createdAt!),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          'Rp ${AppFormat.currency(history.totalPrice ?? '0')}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
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
            if (cInOutHistory.hasNext)
              cInOutHistory.fetchData
                  ? DView.loadingCircle()
                  : Center(
                      child: IconButton(
                        onPressed: () => cInOutHistory.getList(widget.type),
                        icon: const Icon(Icons.refresh),
                      ),
                    ),
          ],
        );
      }),
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
              lastDate: DateTime(
                DateTime.now().year,
                DateTime.now()
                    .add(const Duration(days: 30))
                    .month, // next Month
              ),
            );
            if (result != null) {
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
            suffixIcon: IconButton(
              onPressed: () {
                if (controllerSearch.text != '') {
                  cInOutHistory.search(controllerSearch.text, widget.type);
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
