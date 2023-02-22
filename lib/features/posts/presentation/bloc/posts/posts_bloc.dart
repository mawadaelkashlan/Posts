// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/core/strings/failures.dart';

import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:posts/features/posts/domain/entities/post_entity.dart';
import 'package:posts/features/posts/domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final FailureOrPosts = await getAllPosts();
        FailureOrPosts.fold(
          (failure) {
            emit(ErrorPostsState(message: mapFailureToMessage(failure))
                as PostsState);
          },
          (posts) {
            emit(LoadedPostsState(posts: posts));
          },
        );
      }
    });
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;

      default:
        return "Unexpected Error , please try again later";
    }
  }
}
