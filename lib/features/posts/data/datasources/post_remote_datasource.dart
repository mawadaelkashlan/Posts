import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts/core/error/exception.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Unit> updatePost(PostModel post);

  Future<Unit> addPost(PostModel post);
}

const baseUrl = "https://jsonplaceholder.typiode.com";
const endPoint = "/posts/";

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse(baseUrl + endPoint),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {
      "title": post.title,
      "body": post.body,
    };
    final response =
        await client.post(Uri.parse(baseUrl + endPoint), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse(baseUrl + endPoint + postId.toString()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id.toString();
    final body = {
      "title": post.title,
      "body": post.body, 
    };
    final response =
        await client.patch(Uri.parse(baseUrl + endPoint + postId), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
