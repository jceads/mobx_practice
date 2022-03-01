import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/app_constants/enums.dart';
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
  var colorList = [
    Colors.amber,
    Colors.blue,
    Colors.cyan,
    Colors.brown,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lime,
  ];
  @action
  Color getColor(int index) {
    if (index > colorList.length - 1) {
      log("index%length= ${index % colorList.length}");
      return colorList[(index % colorList.length)];
    } else {
      return colorList[index];
    }
  }

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
