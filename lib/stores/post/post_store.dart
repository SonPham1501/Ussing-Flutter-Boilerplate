// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import '../../data/repository.dart';
import '../../models/post/post_list.dart';
import '../../utils/dio/dio_error_util.dart';
import '../error/error_store.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  // repository instance
  late final Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _PostStore(Repository repository) : _repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<PostList?> emptyPostResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<PostList?> fetchPostsFuture = ObservableFuture<PostList?>(emptyPostResponse);

  @observable
  PostList? postList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getPosts() async {
    final future = _repository.getPosts();
    fetchPostsFuture = ObservableFuture(future);

    future.then((postList) {
      this.postList = postList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
