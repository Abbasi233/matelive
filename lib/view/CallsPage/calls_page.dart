import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '/view/utils/my_text.dart';
import '/view/utils/fixedSpace.dart';

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fixedHeight,
                Text("Başarılı Görüşmeler", style: styleH1()),
                fixedHeight,
                MyExpansionPanelList(),
                fixedHeight,
              ],
            )),
      ),
    );
  }
}

class MyExpansionPanelList extends StatefulWidget {
  @override
  _MyExpansionPanelListState createState() => _MyExpansionPanelListState();
}

class _MyExpansionPanelListState extends State<MyExpansionPanelList> {
  List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: 'Book $index',
        expandedValue: 'Details for Book $index goes here',
      );
    });
  }

  List<Item> _books;

  @override
  void initState() {
    super.initState();

    _books = generateItems(8);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _books[index].isExpanded = !isExpanded;
        });
      },
      children: _books.map<ExpansionPanel>((Item item) {
        return _buildExpansionPanel(item);
      }).toList(),
      elevation: 0,
    );
  }

  _buildExpansionPanel(Item item) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText('Görüşme: John Doe', fontSize: 19),
              ImageIcon(
                AssetImage('assets/icons/outgoing_call.png'),
                size: 24,
                color: Colors.green,
              ),
            ],
          ),
        );
      },
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              'Konuşma Detayları',
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyText('Başlangıç: '),
                        MyText(
                          '9 Eylül 12:20',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        MyText('Bitiş: '),
                        MyText(
                          '9 Eylül 12:55',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    MyText(
                      'Süre',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(height: 5),
                    MyText(
                      '35 DK',
                      fontSize: 23,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      isExpanded: item.isExpanded,
    );
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
