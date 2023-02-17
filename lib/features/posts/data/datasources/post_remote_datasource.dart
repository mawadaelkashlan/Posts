import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future <Unit> deletePost(int postId);
  Future <Unit> updatePost(PostModel post);
  Future <Unit> addPost(PostModel post);

}

class PostRemoteDataSourceImpl extends PostRemoteDataSource{
  @override
  Future<Unit> addPost(PostModel post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
  
}



