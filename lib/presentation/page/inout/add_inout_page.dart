import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddInOutPage extends StatelessWidget {
  const AddInOutPage({Key? key, required this,type}) : super(key: key);
  final String type;

  @override
  Widget build (BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold (
      appBar : AppBar (
        titleSpacing: 0,
        title: Text('Add $type'),
        actions:[
          IconButton(
            onPressed:(){}, 
            icon:const Icon(Icons.check),
            ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(onPressed: (){}, child: const Text ('Pick product'),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: DView.textTitle('List Product'),
          ),
          const Divider(
            indent: 16,endIndent: 16
          ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) {
              return const Divider(
              height: 1,
              color: Colors.white60,
              indent: 16,
              endIndent: 16,
              );
            },
            itemBuilder: (context, index) {
              // Product product = cProduct.list[index];
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
                        "product.name??''",
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DView.spaceHeight(4),
                      Text(
                        "product.code??''",
                        style: textTheme.titleSmall!.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      DView.spaceHeight(16), 
                      Text(
                        "'Rp product.price??'",
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
                            'product.stock.toString()',
                            style: textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                            ),
                          ),
                        DView.spaceHeight(4),
                        Padding(
                            padding: const EdgeInsets.only(right: 16),
                          child: Text(
                              "product.unit??''",
                              style: textTheme.titleSmall!.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'delete') 
                              // Logika untuk menghapus produk
                              // deleteProduct(product.code!);
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
          ),
        ],
      ),
    );

}