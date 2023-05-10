import 'package:baseservice/utility/app_controller.dart';
import 'package:baseservice/utility/app_service.dart';
import 'package:baseservice/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class WidgetSticky extends StatefulWidget {
  const WidgetSticky({super.key});

  @override
  State<WidgetSticky> createState() => _WidgetStickyState();
}

class _WidgetStickyState extends State<WidgetSticky> {
  var headers = <String>[
    'กองทุน',
    'บริษัทจัดการ',
    'รายการ',
    'จำนวนซื่อ',
    'จำนวนหน่วย',
    'จำนวนขาย',
    'ต้นทุนซื้อ',
  ];

  List listContents = <List<String>>[];

  AppController controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < headers.length; i++) {
      var items = <String>[];

      for (var element in controller.transectionModels) {
        switch (i) {
          case 0:
            items.add(element.Fund_Code);
            break;
          case 1:
            items.add(element.Amc_Name);
            break;
          case 2:
            items.add(element.TranType_Code);
            break;
          case 3:
            items.add(element.Amount_Baht.toString());
            break;
          case 4:
            items.add(element.Amount_Unit.toString());
            break;
          case 5:
            items.add('Amount_Unit');
            break;
          case 6:
            items.add('Amount_Unit');
            break;
          default:
        }
      }

      listContents.add(items);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print(
                'transectionModels ---> ${appController.transectionModels.length}');
            return SizedBox(
              width: boxConstraints.maxWidth,
              height: 300,
              child: StickyHeadersTable(
                legendCell: WidgetText(data: 'วันที่'),
                columnsLength: headers.length,
                rowsLength: appController.transectionModels.length,
                columnsTitleBuilder: (columnIndex) =>
                    WidgetText(data: headers[columnIndex]),
                rowsTitleBuilder: (rowIndex) => WidgetText(
                    data: AppService().cutWord(
                        string:
                            appController.transectionModels[rowIndex].TranDate,
                        start: 0,
                        end: 10)),
                contentCellBuilder: (columnIndex, rowIndex) =>
                    WidgetText(data: listContents[columnIndex][rowIndex]),
                onEndScrolling: (x, y) {
                  print('onEnd start');
                },
              ),
            );
          });
    });
  }
}
