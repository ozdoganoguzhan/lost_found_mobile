import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models.dart' as models;

const String base_url = "https://10.0.2.2:7183/api/";
// const String base_url = "https://127.0.0.1:7183/api/";
// const String base_url = "https://jsonplaceholder.typicode.com/";

Future<List<models.Post>> fetchPosts({int pageKey = 0, int size = 0}) async {
  final response = await http.get(Uri.parse("${base_url}posts"),
      headers: {"Access-Control-Allow-Origin": "*"});
  if (response.statusCode != 200) throw Exception("gg");
  final rb = jsonDecode(response.body);
  List<models.Post> temp = [];
  for (var post in rb) {
    temp.add(models.Post.fromJson(post));
  }
  final pkS = pageKey * size;
  final temp2 = temp.getRange(
      pkS.clamp(0, temp.length - 1), (size + (pkS)).clamp(pkS, temp.length));
  return temp2.toList();
}

Future<List<models.Category>> fetchCategories() async {
  final response = await http.get(Uri.parse("${base_url}categories"),
      headers: {"Access-Control-Allow-Origin": "*"});
  if (response.statusCode != 200) throw Exception("gg");
  final rb = jsonDecode(response.body);
  List<models.Category> temp = [];
  for (var post in rb) {
    temp.add(models.Category.fromJson(post));
  }
  return temp;
}

Future<List<models.Post>> fetchPostsByCategory(
    {int pageKey = 0, int size = 0, String categoryId = "none"}) async {
  final response = await http.get(
      Uri.parse("${base_url}posts/search?categoryId=$categoryId"),
      headers: {"Access-Control-Allow-Origin": "*"});
  if (response.statusCode != 200) throw Exception("gg");
  final rb = jsonDecode(response.body);
  List<models.Post> temp = [];
  for (var post in rb) {
    temp.add(models.Post.fromJson(post));
  }
  final pkS = pageKey * size;
  final temp2 = temp.getRange(
      pkS.clamp(0, temp.length - 1), (size + (pkS)).clamp(pkS, temp.length));
  return temp2.toList();
}

Future<models.Post> fetchPostById(int postId) async {
  return models.Post.fromJson(
      jsonDecode((await http.get(Uri.parse("${base_url}posts/$postId"))).body));
}

Future<List<models.Post>> fetchPostsByUserId(int userId) async {
  final response = await http.get(
      Uri.parse("${base_url}posts/search?userId=$userId"),
      headers: {"Access-Control-Allow-Origin": "*"});
  if (response.statusCode != 200) throw Exception("gg");
  final rb = jsonDecode(response.body);
  List<models.Post> temp = [];
  for (var post in rb) {
    temp.add(models.Post.fromJson(post));
  }
  return temp.toList();
}

Future<int> fetchUserPostCount(int userId) async {
  final response = await http.get(
      Uri.parse("${base_url}posts/search?userId=$userId"),
      headers: {"Access-Control-Allow-Origin": "*"});
  if (response.statusCode != 200) throw Exception("gg");
  final rb = jsonDecode(response.body);
  int temp = 0;
  for (var post in rb) {
    temp++;
  }
  return temp;
}

Future<models.User> fetchUserById(int userId) async {
  return models.User.fromJson(
      jsonDecode((await http.get(Uri.parse("${base_url}users/$userId"))).body));
}

Future<models.User?> fetchUserByEmail(String email) async {
  var resp = jsonDecode(
      (await http.get(Uri.parse("${base_url}users/search?email=$email"))).body);
  if (resp == null)
    return null;
  else
    return models.User.fromJson(resp);
}

// Future<models.User> postUser(models.User user) async {
//   return await http.post(Uri.parse("${base_url}upload/poast-image"))
// }

Future<models.Post> postPost(Map<String, String> post) async {
  return jsonDecode(
      (await http.post(Uri.parse("${base_url}posts/"), body: jsonEncode(post)))
          .body);
}
