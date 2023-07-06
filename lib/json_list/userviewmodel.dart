import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterv1/json_list/usermodel.dart';

class UserViewModel {
  Future<List> getUsers() async {
    try {
      http.Response hasil = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
        headers: {"Accept": "application/json"},
      );

      if (hasil.statusCode == 200) {
        print("Data category success");
        final data = userModelFromJson(hasil.body);
        return data;
      } else {
        print("Error status: ${hasil.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error catch: $e");
      return [];
    }
  }
}
