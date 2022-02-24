import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/view/utils/appBar.dart';
import '/model/user_detail.dart';
import '/view/utils/snackbar.dart';
import '/model/paged_response.dart';
import '/view/utils/progressIndicator.dart';

class BlocksPage extends StatefulWidget {
  const BlocksPage({Key key}) : super(key: key);
  @override
  State<BlocksPage> createState() => _BlocksPageState();
}

class _BlocksPageState extends State<BlocksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          "Engellenenler",
          style: styleH3(),
        ),
      ),
      body: FutureBuilder<Map<bool, dynamic>>(
        future: API().getBlockedUsers(Login().token),
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
                    child: ListTile(
                      title: Text(
                        "${(pagedResponse.data[index] as UserDetail).name} ${(pagedResponse.data[index] as UserDetail).surname}",
                        style: styleH4(),
                      ),
                      trailing: TextButton(
                        child: Text("Engeli Kaldır"),
                        onPressed: () async {
                          var dialogResult = await Get.dialog(
                            AlertDialog(
                              title: Text("Engeli Kaldır"),
                              content: Text(
                                  "Bu kullanıcının engelini kaldırmak istediğinize emin misiniz."),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "Tamam",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () => Get.back(result: true),
                                ),
                                TextButton(
                                  child: Text("Vazgeç"),
                                  onPressed: () => Get.back(result: false),
                                ),
                              ],
                            ),
                          );

                          if (dialogResult != null && dialogResult) {
                            var map = {
                              "type": 5,
                              "related_user_id":
                                  (pagedResponse.data[index] as UserDetail).id,
                            };
                            var result = await API().setAction(
                              Login().token,
                              map,
                            );

                            if (result.keys.first) {
                              successSnackbar(result.values.first);
                            } else {
                              failureSnackbar(result.values.first);
                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => Divider(),
                );
              } else {
                return Center(
                  child: Text("Henüz engellediğiniz bir kullanıcı yok."),
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
