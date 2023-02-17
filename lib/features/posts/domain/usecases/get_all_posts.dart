import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/domain/repositories/posts_reposatory.dart';

import '../../../../core/error/failures.dart';
import '../entities/post_entity.dart';

class GetAllPostsUsecase{
  final PostsRepository repository;

  GetAllPostsUsecase(this.repository);
  Future<Either<Failure , List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}