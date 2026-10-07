import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class ApiService {
  // DummyJSON returns real English sample posts.
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts?limit=50'),
    );

    if (response.statusCode == 200) {
      // DummyJSON wraps the list: { "posts": [...], "total": ..., ... }
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> posts = data['posts'];

      return posts
          .map((json) => Post.fromJson(json))
          .toList();
    }

    throw Exception(
      'Failed to load posts. Status code: ${response.statusCode}',
    );
  }

  // DummyJSON accepts DELETE requests (returns 200) but does not actually
  // remove the data on the server, so the UI removes it locally.
  Future<void> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete post. Status code: ${response.statusCode}',
      );
    }
  }
}
