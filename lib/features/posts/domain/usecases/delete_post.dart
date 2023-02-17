import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/domain/repositories/posts_reposatory.dart';

import '../../../../core/error/failures.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase(this.repository);
  Future<Either<Failure , Unit>> call(int postId) async {
    return repository.deletePost(postId);
  }
}