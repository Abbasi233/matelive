import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({Key key}) : super(key: key);
  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  int selectedIndex = 0;
  final List<String> reportDescription = [
    "Sahte hesap olduğundan.",
    "Uygunsuz fotoğraf paylaşımlarında bulunduğundan.",
    "Görüşme esnasında çok kaba davrandığından.",
    "Irkçılık veya kışkırtıcı davranışlar sebebiyle.",
    "Kişisel bilgilerinde yanlış ya da uygunsuz içerikler bulunduğundan.",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.all(20),
      child: AlertDialog(
        title: Text("Şikayet Et"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Bu kullanıcıyı neden şikayet etmek istiyorsunuz?",
            ),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: index + 1,
                  groupValue: selectedIndex,
                  title: Text(reportDescription[index]),
                  onChanged: (int i) => setState(() => selectedIndex = i),
                  contentPadding: const EdgeInsets.symmetric(vertical: 3),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              "Şikayet Et",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Get.back(result: reportDescription[selectedIndex - 1]),
          ),
          TextButton(
            child: Text("Vazgeç"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
