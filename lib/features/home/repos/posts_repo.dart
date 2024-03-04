import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:my_app/features/home/models/home_data_ui_model.dart';

class PostRepos {
  static Future<List<Post>> fetchPosts() async {
    var client = http.Client();
    List<Post> posts = [];

    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        Post post = Post.fromJson(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
    } catch (e) {
      print("httpError:$e");
      return [];
    } finally {
      client.close();
    }
    return posts;
  }
}
