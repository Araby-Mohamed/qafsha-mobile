import 'package:afsha/screen/order_status_details/order_status_details.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextWidget({Key key}) : super(key: key);

  List<String> _dataList = ['Flutter', "android", "IOS"];

  ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: _dataList.length,
          itemBuilder: (context, index) {
            final String item = _dataList[index];
            return ValueListenableBuilder(
                valueListenable: selectedIndexNotifier,
                builder: (_, int selectedIndex, __) {
                  bool isSelected = selectedIndex == index;
                  return InkWell(
                    onTap: () => selectedIndexNotifier.value = index,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      color: isSelected ? Colors.red : Colors.transparent,
                      child: Text(item),
                    ),
                  );
                });
          }),
    );
  }
}
