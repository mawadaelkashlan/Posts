import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/data/models/post_model.dart';


abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedData();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostLocalDataSourceImpl extends PostLocalDataSource{
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedData() {
    // TODO: implement getCachedData
    throw UnimplementedError();
  }
}