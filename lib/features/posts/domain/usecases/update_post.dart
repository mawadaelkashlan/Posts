import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/domain/repositories/posts_reposatory.dart';
import '../../../../core/error/failures.dart';
import '../entities/post_entity.dart';

class UpdatePzostUsecase{
  final PostsRepository repository;

  UpdatePzostUsecase(this.repository);
  Future<Either<Failure , Unit>> call(Post post ) async {
    return repository.updatePost(post);
  }
}