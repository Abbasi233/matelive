import 'package:flutter/material.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/model/paged_response.dart';
import 'package:matelive/view/HomePage/OnlineUsersPage/utils/user_card.dart';
import 'package:matelive/view/utils/progressIndicator.dart';

import '/constant.dart';
import '/view/utils/appBar.dart';
import '/model/action.dart' as my;

class ActionsPage extends StatelessWidget {
  const ActionsPage(this.title, this.actionType, {Key key}) : super(key: key);
  final String actionType;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          title,
          style: styleH3(),
        ),
      ),
      body: FutureBuilder<Map<bool, dynamic>>(
        future: API().getActions(Login().token, actionType),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            if (data.keys.first) {
              var pagedResponse = data.values.first as PagedResponse;

              if (pagedResponse.data.isNotEmpty) {
                return ListView.separated(
                  itemCount: pagedResponse.data.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: userCard(
                      userDetail:
                          (pagedResponse.data[index] as my.Action).relatedUser,
                      showActionButtons: false,
                    ),
                  ),
                  separatorBuilder: (context, index) => Divider(),
                );
              } else {
                return Center(
                  child: Text("Henüz bir aktiviteniz yok."),
                );
              }
            }
          }

          return showProgressIndicator(context);
        },
      ),
    );
  }
}
