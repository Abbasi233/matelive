import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/view/utils/footer.dart';
import 'utils/expansion_panel.dart';
import '/view/utils/progressIndicator.dart';

class CallsPage extends StatefulWidget {
  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage>
    with SingleTickerProviderStateMixin {
  var callsFuture = API().getCalls(Login().token);

  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: FutureBuilder<Map<bool, dynamic>>(
          future: callsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.keys.first) {
                return SmartRefresher(
                  enablePullDown: true,
                  onRefresh: _onRefresh,
                  controller: _refreshController,
                  header: MaterialClassicHeader(),
                  physics: BouncingScrollPhysics(),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fixedHeight,
                        Text("Başarılı Görüşmeler", style: styleH1()),
                        fixedHeight,
                        CallsExpansionPanel(snapshot.data.values.first),
                        fixedHeight,
                        footer(),
                      ],
                    ),
                  ),
                );
              }
            }
            return showProgressIndicator(context);
          },
        ),
      ),
    );
  }

  void _onRefresh() async {
    var newFuture = await API().getCalls(Login().token);
    setState(() {
      callsFuture = Future.value(newFuture);
    });
    _refreshController.refreshCompleted();
  }
}
