import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:electrosphereinventory/config/app_color.dart';
import 'package:electrosphereinventory/data/model/history.dart';
import 'package:electrosphereinventory/presentation/controller/c_in_out.dart';
import 'package:electrosphereinventory/presentation/page/history/detail_history_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'add_inout_page.dart';
import 'inout_history_page.dart';


class InOutPage extends StatefulWidget {
  const InOutPage({super.key, required this.type});
  final String type;

  @override
  State<InOutPage> createState() => _InOutPageState();
}

class _InOutPageState extends State<InOutPage> {
  final cInOut = Get.put(CInOut());
  @override
  void initState() {
    cInOut.getAnalysis(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Data untuk pie chart
final List<OrdinalData> ordinalDataList = [
  OrdinalData(
    domain: 'Today',
    measure: cInOut.listTotal.length > 5 ? cInOut.listTotal[5] : 0, // Aman dengan panjang cek
    color: widget.type == 'IN' ? AppColor.historyIn : AppColor.historyOut,
  ),
  OrdinalData(
    domain: 'Yesterday',
    measure: cInOut.listTotal.length > 6 ? cInOut.listTotal[6] : 0, // Aman dengan panjang cek
    color: AppColor.primary,
  ),
];

// Kondisi tambahan
if (cInOut.listTotal.length > 6 && cInOut.listTotal[6] == 0 && cInOut.listTotal[5] == 0) {
  ordinalDataList.add(
    OrdinalData(
      domain: 'Nol',
      measure: 1,
      color: Colors.white.withOpacity(0.5), // Tambahkan warna jika perlu
    ),
  );
}



    // Data untuk bar chart
    final List<OrdinalData> data = List.generate(
      cInOut.listTotal.length,
      (index) => OrdinalData(
        domain: cInOut.week()[index],
        measure: cInOut.listTotal[index],
        color: AppColor.historyIn, // Tambahkan warna jika diperlukan
      ),
    );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(widget.type),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddInOutPage(type: widget.type))?.then((value)
               {if(value??false){
                cInOut.getAnalysis(widget.type);
               }
                 
             } );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        //DChart Pie
                        DChartPieO(
                          data: ordinalDataList,
                          customLabel: (ordinalData, index) {
                            return '${ordinalData.measure}';
                          },
                          configRenderPie: const ConfigRenderPie(
                            strokeWidthPx: 0,
                            arcWidth: 20,
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            return Center(
                              child: Text(
                                '${cInOut.percentToday.toStringAsFixed((1))}%'
                                ,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                  DView.spaceWidth(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                            color: widget.type == 'IN' ? AppColor.historyIn : AppColor.historyOut,
                              
                            ),
                            DView.spaceWidth(8),
                            Text(
                              'Today',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        DView.spaceHeight(),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              color: AppColor.primary,
                            ),
                            DView.spaceWidth(8),
                            Text(
                              'Yesterday',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        DView.spaceHeight(30),
                        Builder(
                          builder: (context) {
                            return Text(
                              '${cInOut.percentDifferent}% ${cInOut.textDifferent}\nthan yesterday\nor equal to',
                              maxLines: 5,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w300,
                                  ),
                            );
                          }
                        ),
                        DView.spaceHeight(8),
                        Builder(
                          builder: (context) {
                            return Text(
                              'Rp ${cInOut.different.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                color: widget.type == 'IN' ? AppColor.historyIn : AppColor.historyOut,
                                    fontWeight: FontWeight.bold,
                                  ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                  DView.spaceWidth(16),
                ],
              ),
            ),
          ),

          // DChartBar
          GetBuilder<CInOut>(
            builder: (_) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DChartBarO(
                    layoutMargin: LayoutMargin(40, 10, 10, 10),
                    barLabelValue: (group, data, index) {
                      return ''; // Tidak menampilkan label di atas batang
                    },
                    configRenderBar: ConfigRenderBar(
                      showBarLabel: true,
                      barLabelDecorator: BarLabelDecorator(
                        barLabelPosition: BarLabelPosition.inside,
                        insideLabelStyle: const LabelStyle(
                          fontSize: 8,
                          color: Colors.black,
                        ),
                      ),
                      barGroupInnerPaddingPx: 0,
                      radius: 4,
                    ),
                    domainAxis: const DomainAxis(
                      showLine: false,
                      tickLength: 0,
                      gapAxisToLabel: 12,
                      labelStyle: LabelStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    measureAxis: MeasureAxis(
                      tickLength: 0,
                      gapAxisToLabel: 8,
                      tickLabelFormatter: (measure) {
                        return NumberFormat.compactCurrency(
                          decimalDigits: 0,
                          symbol: '',
                        ).format(measure);
                      },
                      numericTickProvider: const NumericTickProvider(
                        desiredMinTickCount: 6,
                        desiredMaxTickCount: 10,
                      ),
                      labelStyle: const LabelStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    groupList: [
                      OrdinalGroup(
                        id: '1',
                        data: data,
                        color: widget.type == 'IN' ? AppColor.historyIn : AppColor.historyOut,
                        
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // ignore: deprecated_member_use
          DView.spaceHeight(8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                DView.textTitle('History ${widget.type}', color: Colors.white),
                const Spacer(),
                DView.textAction(
                  () {
                    Get.to(()=> InOutHistoryPage(type: widget.type));
                  },
                  color: AppColor.primary,
                  iconRight: Icons.navigate_next,
                  iconRightColor: AppColor.primary,
                ),
              ],
            ),
          ),

          // History IN
          GetBuilder<CInOut>(builder: (_) {
            if (cInOut.list.isEmpty) return DView.empty();
            return ListView.separated(
              itemCount: cInOut.list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: Colors.white54,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                History history = cInOut.list[index];
                return ListTile(
                   onTap:() {
                        Get.to(()=>DetailHistoryPage (idhHistory: '${history.idHistory}',));
                      },
                  leading: widget.type=='IN' 
                  ? const Icon(Icons.south_west, color: Colors.green)
                  : const Icon(Icons.north_east, color: Colors.red),
                  horizontalTitleGap: 0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        history.createdAt ?? '',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        'Rp ${history.totalPrice}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}