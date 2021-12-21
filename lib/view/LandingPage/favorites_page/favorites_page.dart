import 'package:flutter/material.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/view/utils/appBar.dart';
import '/model/paged_response.dart';
import '/view/utils/progressIndicator.dart';
import '/view/HomePage/OnlineUsersPage/utils/user_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          "Favoriler",
          style: styleH3(),
        ),
      ),
      body: FutureBuilder<Map<bool, dynamic>>(
        future: API().getFavorites(Login().token),
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
                      showActionButtons: false,
                      userDetail: pagedResponse.data[index],
                    ),
                  ),
                  separatorBuilder: (context, index) => Divider(),
                );
              } else {
                return Center(
                  child: Text("Henüz favorilediğiniz bir kullanıcı yok."),
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
