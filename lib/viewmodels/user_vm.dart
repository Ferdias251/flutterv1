import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterv1/models/model.dart';

class UserViewModel {
  Future getUsers() async {
    try {
      http.Response hasil = await http.get(
        Uri.parse("http://192.168.1.3/APIV1/user_api/list.php"),
        headers: {"Accept": "application/json"}
      );

      if (hasil.statusCode == 200) {
        final data = UserFromJson(hasil.body);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future deleteUser(String id) async {
    Map data = {"id": id};

    try {
      http.Response hasil = await http.post(
        Uri.parse("http://192.168.1.3/APIV1/user_api/delete.php"),
        headers: {"Accept": "application/json"},
        body: json.encode(data)
      );

      if (hasil.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future createUser(String name, String email, String password) async {
    Map data = {"name": name, "email": email, "password": password};

    try {
      http.Response hasil = await http.post(
        Uri.parse("http://192.168.1.3/APIV1/user_api/create.php"),
        headers: {"Accept": "application/json"},
        body: json.encode(data)
      );

      if (hasil.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future editUser(String id, String name, String email, String password) async {
    Map data = {"id": id, "name": name, "email": email, "password": password};

    try {
      http.Response hasil = await http.post(
        Uri.parse("http://192.168.1.3/APIV1/user_api/update.php"),
        headers: {"Accept": "application/json"},
        body: json.encode(data)
      );

      if (hasil.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
