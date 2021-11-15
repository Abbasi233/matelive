import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:matelive/model/login.dart';
import 'package:matelive/model/notifications.dart';
import 'package:matelive/model/paged_response.dart';
import 'package:matelive/model/profile_detail.dart';
import 'package:matelive/model/total_notifications.dart';
import 'package:matelive/model/user_detail.dart';
import 'package:matelive/view/utils/progressIndicator.dart';
import 'package:matelive/view/utils/progress_dialog.dart';

class API {
  API.instance();
  factory API() => _api;
  static final API _api = API.instance();

  static const _URL = "https://matelive.net/api";

  Map<String, String> _getHeader(String token) => {
        "Accept": "Application/json",
        "X-Requested-With": "XMLHttpRequest",
        "Content-Type": "Application/json",
        'Authorization': 'Bearer $token',
      };

  Future<bool> login(Map<String, String> body) async {
    showProgressDialog();
    Uri url = Uri.parse("$_URL/auth/login");
    http.Response response = await http.post(
      url,
      headers: {
        "Accept": "Application/json",
        "X-Requested-With": "XMLHttpRequest",
        "Content-Type": "Application/json",
      },
      body: convert.jsonEncode(body),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    closeProgressDialog();

    if (jsonResponse.containsKey("data")) {
      print(jsonResponse["data"]);
      Login.fromJson(jsonResponse["data"]);
      return true;
    }

    return false;
  }

  Future<bool> register(Map<String, dynamic> body) async {
    showProgressDialog();
    Uri url = Uri.parse("$_URL/auth/register");
    http.Response response = await http.post(
      url,
      headers: {
        "Accept": "Application/json",
        "X-Requested-With": "XMLHttpRequest",
        "Content-Type": "Application/json",
      },
      body: convert.jsonEncode(body),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    closeProgressDialog();
    print(jsonResponse);

    if (jsonResponse.containsKey("data")) {
      return true;
    }
    return false;
  }

  Future<String> sendResetPasswordMail(Map<String, dynamic> body) async {
    showProgressDialog();
    Uri url = Uri.parse("$_URL/auth/password/mail");
    http.Response response = await http.post(
      url,
      headers: {
        "Accept": "Application/json",
        "X-Requested-With": "XMLHttpRequest",
        "Content-Type": "Application/json",
      },
      body: convert.jsonEncode(body),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    closeProgressDialog();
    print(jsonResponse);

    if (jsonResponse.containsKey("errors")) {
      return jsonResponse["errors"]["email"][0];
    }
    return jsonResponse["message"];
  }

  Future<bool> logout(String token) async {
    showProgressDialog();
    Uri url = Uri.parse("$_URL/auth/logout");
    http.Response response = await http.post(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    closeProgressDialog();
    print(jsonResponse);

    if (jsonResponse.containsKey("data")) {
      return true;
    }
    return false;
  }

  Future<String> sendVerifyEmail(String token) async {
    showProgressDialog();
    Uri url = Uri.parse("$_URL/auth/email/mail");
    http.Response response = await http.post(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    closeProgressDialog();
    print(jsonResponse);

    return jsonResponse["message"];
  }

  Future<dynamic> getProfile(String token) async {
    Uri url = Uri.parse("$_URL/auth-user/profile");
    http.Response response = await http.get(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    if (jsonResponse.containsKey("data")) {
      return ProfileDetail.fromJson(jsonResponse["data"]);
    }
    return jsonResponse["message"];
  }

  // gallery parametresini profile nesnesiyle neden birleştirmedi ? ikisni ayrı ayrı çekmeye gerek var mı
  Future<dynamic> getImages(String token) async {
    Uri url = Uri.parse("$_URL/auth-user/images");
    http.Response response = await http.get(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    if (jsonResponse.containsKey("data")) {
      return UserDetail.fromJson(jsonResponse["data"]);
    }
    return jsonResponse["message"];
  }

  Future<Map<bool, String>> updatePassword(String token, dynamic body) async {
    showProgressDialog();
    Uri url = Uri.parse("$_URL/auth-user/update-password");
    http.Response response = await http.put(
      url,
      headers: _getHeader(token),
      body: convert.jsonEncode(body),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    closeProgressDialog();
    print(jsonResponse);

    if (jsonResponse["status"] == "success") {
      return {true: jsonResponse["message"]};
    }
    return {false: jsonResponse["message"]};
  }

  Future<Map<bool, String>> updateProfile(String token, dynamic body) async {
    showProgressDialog();
    Uri url = Uri.parse("$_URL/auth-user/update-profile");
    http.Response response = await http.put(
      url,
      headers: _getHeader(token),
      body: convert.jsonEncode(body),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    closeProgressDialog();
    print(jsonResponse);

    if (jsonResponse.containsKey("data")) {
      UserDetail.fromJson(jsonResponse["data"]);
      return {true: "Profil bilgileriniz başarıyla güncellendi."};
    }
    return {false: jsonResponse["message"]};
  }

  Future<bool> setActivity(String token) async {
    Uri url = Uri.parse("$_URL/auth-user/set-activity");
    http.Response response = await http.post(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    if (jsonResponse.containsKey("data")) {
      return true; // tam olarak ne dönüleceğine karar veremedim
    }
    return false; // tam olarak ne dönüleceğine karar veremedim
  }

  Future<Map<bool, dynamic>> getTotalNotifications(String token) async {
    Uri url = Uri.parse("$_URL/notification/totals");
    http.Response response = await http.get(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    if (response.statusCode < 400) {
      return {true: TotalNotifications.fromJson(jsonResponse["data"])};
    }
    return {false: jsonResponse["message"]};
  }

  Future<Map<bool, dynamic>> getNotificationsByType(
      String token, String type) async {
    /*'types' => [
            'system' => 1,
            'favorite' => 2,
            'like' => 3,
            'snooze' => 4
      ]*/
    Uri url = Uri.parse("$_URL/notification/type/$type");
    http.Response response = await http.get(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    if (response.statusCode < 400) {
      return {true: PagedResponse.fromJson(jsonResponse, Notification)};
    }
    return {false: jsonResponse["message"]};
  }

  Future<dynamic> getNotificationDetail(String token) async {
    // url'deki 44 değeri ne için? başka sayılar da denedim hepsinde çalışıyor.
    Uri url = Uri.parse("$_URL/notification/44");
    http.Response response = await http.get(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    if (response.statusCode < 400) {
      return PagedResponse.fromJson(jsonResponse["data"], Notification);
    }
    return jsonResponse["message"];
  }

  Future<dynamic> delNotification(String token, int id) async {
    showProgressDialog();
    Uri url = Uri.parse("$_URL/notification/$id");
    http.Response response = await http.delete(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    closeProgressDialog();
    print(jsonResponse);

    if (response.statusCode < 400) {
      return true;
    }
    return jsonResponse["message"];
  }

  Future<dynamic> clearNotification(String token) async {
    showProgressDialog();
    Uri url = Uri.parse("$_URL/notification/clear");
    http.Response response = await http.delete(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    closeProgressDialog();
    print(jsonResponse);

    if (response.statusCode < 400) {
      return true;
    }
    return jsonResponse["message"];
  }

  Future<Map<bool, dynamic>> getOnlineUsers(
      String token, String gender, String page) async {
    Uri url = Uri.parse("$_URL/users/online?gender=$gender&page=$page");
    http.Response response = await http.get(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    if (response.statusCode < 400) {
      return {true: PagedResponse.fromJson(jsonResponse, UserDetail)};
    }
    return {false: jsonResponse["message"]};
  }

  Future<Map<bool, dynamic>> getAllUsers(
      String token, String gender, String search, String page) async {
    Uri url = Uri.parse("$_URL/users?gender=$gender&search=$search&page=$page");
    http.Response response = await http.get(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    if (response.statusCode < 400) {
      return {true: PagedResponse.fromJson(jsonResponse, UserDetail)};
    }
    return {false: jsonResponse["message"]};
  }

  Future<dynamic> getUserDetail(String token, int id) async {
    Uri url = Uri.parse("$_URL/users/detail/$id");
    http.Response response = await http.get(
      url,
      headers: _getHeader(token),
    );
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    if (jsonResponse.containsKey("data")) {
      return UserDetail.fromJson(jsonResponse["data"]);
    }
    return jsonResponse["message"];
  }
}
