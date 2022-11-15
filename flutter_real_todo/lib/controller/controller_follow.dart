
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class FollowController extends GetxController {
  final defaultUrl = "http://localhost:8080";
  final mobileUrl = "http://10.0.2.2:8080";
  final _follows = [].obs;
  final check = false.obs;

  Future<void> insertFollow(String target, String userid) async {
    var url = Uri.parse("$defaultUrl/follow/insertFollow");
    try {
      if(Platform.isAndroid || Platform.isIOS) {
        url = Uri.parse("$mobileUrl/follow/insertFollow");
      }
    } catch(e) {
      print(e);
    }

    await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "target" : {
          "id" : target
        },
        "users" : {
          "id" : userid
        }
      }),
    ).then((value) {
      if(value.statusCode == 200) {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Follow",
            message: "Follow Success",
            duration: Duration(seconds: 1),
          )
        );
        _follows.add(target);
        check(true);
      }
    });
  }

  Future<void> unFollow(String target, String userid) async {
    var url = Uri.parse("$defaultUrl/follow/unFollow");
    try {
      if(Platform.isAndroid || Platform.isIOS) {
        url = Uri.parse("$mobileUrl/follow/unFollow");
      }
    } catch(e) {
      print(e);
    }

    await http.delete(
      url,
      headers: {"Content-Type" : "application/json"},
      body: json.encode({
        "target" : {
          "id" : target
        },
        "users" : {
          "id" : userid
        }
      }),
    ).then((value) {
      if(value.statusCode == 200) {
        Get.showSnackbar(
            const GetSnackBar(
              title: "Follow",
              message: "unFollow Success",
              duration: Duration(seconds: 1),
            )
        );
        _follows.remove(target);
        check(false);
      }
    });
  }

  Future<void> checkFollow(String target, String userId) async {
    var url = Uri.parse("$defaultUrl/follow/checkFollow/$target/$userId");
    try {
      if(Platform.isAndroid || Platform.isIOS) {
        url = Uri.parse("$mobileUrl/follow/checkFollow/$target/$userId");
      }
    } catch(e) {
      print(e);
    }

    await http.get(url).then((value) {
      if(value.statusCode == 200) {
        print("result ${value.body} ");
        check(json.decode(value.body));
      }
    });
  }

  List<dynamic> getfollows() {
    return _follows;
  }
}