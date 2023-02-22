import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/core/strings/messages.dart';
import 'package:posts/features/posts/domain/usecases/add_post.dart';
import 'package:posts/features/posts/domain/usecases/delete_post.dart';
import 'package:posts/features/posts/domain/usecases/update_post.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/post_entity.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUsecase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUsecase updatePost;
  AddDeleteUpdatePostBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostInitial());

        final failureOrDoneMessage = await addPost(event.post);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, addSuccessMessage));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostInitial());

        final failureOrDoneMessage = await updatePost(event.post);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, updateSuccessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostInitial());

        final failureOrDoneMessage = await deletePost(event.postId);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, deleteSuccessMessage));
      }
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostInitial(
          message: mapFailureToMessage(failure)),
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;

      default:
        return "Unexpected Error , please try again later";
    }
  }
}
