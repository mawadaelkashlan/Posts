import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:posts/core/error/exception.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedData();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostLocalDataSourceImpl extends PostLocalDataSource {
  final SharedPreferences sharedPreferences;
  final CACHED_POST = 'CACHED_POSTS';
  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POST, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedData() {
    final jsonString = sharedPreferences.getString(CACHED_POST);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
