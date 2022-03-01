import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../view_model/post_view_model.dart';

class PostView extends StatelessWidget {
  final _viewModel = PostViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Observer(builder: (_) {
        switch (_viewModel.pageState) {
          case PageState.LOADING:
            return const Center(child: CircularProgressIndicator());
          case PageState.DONE:
            return BuildListView();
          case PageState.ERROR:
            return const Center(child: Text("Error"));
          case PageState.NORMAL:
            return const Center(
              child: Text("waiting"),
            );
          default:
            return const Center(
              child: Text("normal"),
            );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewModel.getAllPost,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  ListView BuildListView() {
    return ListView.builder(
        itemBuilder: (context, index) {
          final model = _viewModel.posts[index];
          return Card(
            child: ListTile(
              title: Text("${model.title}"),
              subtitle: Text("${model.body}"),
              trailing: Text(model.id.toString()),
            ),
          );
        },
        itemCount: _viewModel.posts.length);
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Ruchan"),
      leading: Observer(
        builder: (context) => Visibility(
          visible: _viewModel.isServiceRequestLoading,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
