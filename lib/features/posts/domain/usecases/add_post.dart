import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/domain/entities/post_entity.dart';
import 'package:posts/features/posts/domain/repositories/posts_reposatory.dart';

import '../../../../core/error/failures.dart';

class AddPostUsecase{
  final PostsRepository repository;

  AddPostUsecase({required this.repository});
  Future<Either<Failure , Unit>> call(Post post) {
    return repository.addPost(post);
  }
}