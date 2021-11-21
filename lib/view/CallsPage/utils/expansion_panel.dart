import 'package:flutter/material.dart';
import 'package:matelive/model/calls.dart';
import 'package:matelive/model/paged_response.dart';
import 'package:matelive/model/profile_detail.dart';
import 'package:matelive/view/utils/my_text.dart';
import 'package:matelive/extensions.dart';

class CallsExpansionPanel extends StatefulWidget {
  final PagedResponse pagedResponse;
  CallsExpansionPanel(this.pagedResponse);
  @override
  _CallsExpansionPanelState createState() => _CallsExpansionPanelState();
}

class _CallsExpansionPanelState extends State<CallsExpansionPanel> {
  List<Calls> _calls;

  @override
  void initState() {
    super.initState();

    _calls = List.from(widget.pagedResponse.data);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _calls[index].isExpanded = !isExpanded;
        });
      },
      children: _calls.map<ExpansionPanel>((Calls item) {
        return _buildExpansionPanel(item);
      }).toList(),
      elevation: 0,
    );
  }

  ExpansionPanel _buildExpansionPanel(Calls call) {
    bool iCaller = call.caller.id == ProfileDetail().id ? true : false;

    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                "${iCaller ? '${call.answerer.name} ${call.answerer.surname}' : '${call.caller.name} ${call.caller.surname}'} ",
                fontSize: 19,
                overflow: TextOverflow.fade,
              ),
              Icon(
                iCaller
                    ? Icons.phone_forwarded_rounded
                    : Icons.phone_callback_rounded,
                color: iCaller ? Colors.green : Colors.blue,
              )
            ],
          ),
        );
      },
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 16),
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
                          call.callStartedAt.formatWithMonthName() ??
                              "Bilgi Bulunamadı",
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
                          call.callEndedAt.formatWithMonthName() ??
                              "Bilgi Bulunamadı",
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
                      formatDuration(call.durationSeconds),
                      fontSize: 18,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      isExpanded: call.isExpanded,
    );
  }

  String formatDuration(int seconds) {
    String returnValue = "";
    var data = Duration(seconds: seconds);
    var fullTime = data.toString().split(".");
    var time = fullTime[0].split(":");

    if (time[0] != "0") {
      returnValue += "${time[0]}s ";
    }
    if (time[1] != "00") {
      returnValue += "${time[1]}dk ";
    }
    if (time[2] != "00") {
      returnValue += "${time[2]}sn";
    }

    return returnValue == "" ? "Süre Yok" : returnValue;
  }
}
