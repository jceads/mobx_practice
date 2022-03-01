import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../model/postmodel.dart';
part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase with Store {
  @observable
  List<Post> posts = [];

  final url = "https://jsonplaceholder.typicode.com/posts";

  @observable
  bool isServiceRequestLoading = false;
  @observable
  PageState pageState = PageState.NORMAL;

  @action
  Future<void> getAllPost() async {
    pageState = PageState.LOADING;
    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      final responseData = response.data as List;
      posts = responseData.map((e) => Post.fromJson(e)).toList();
    }
    pageState = PageState.DONE;
  }

  @action
  void changeRequest() {
    isServiceRequestLoading = !isServiceRequestLoading;
  }
}

enum PageState {
  LOADING,
  ERROR,
  DONE,
  NORMAL,
}
