import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/constans/enum.dart';
import '../view_model/post_view_model.dart';

class PostView extends StatelessWidget {
  String appbarName = "Mobx-dio";
  String error = 'Error';
  final _viewModel = PostViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.getAllPost();
        },
      ),
      body: buildListViewPosts(),
    );
  }

  Center buildCenterLikeCubic() {
    return Center(child: Observer(builder: (_) {
      switch (_viewModel.pageState) {
        case PageState.LOADING:
          return CircularProgressIndicator();
        case PageState.SUCCESS:
          return buildListViewPosts();

        case PageState.ERROR:
          return Center(child: Text(error));
        default:
          return FlutterLogo();
      }
    }));
  }

  Widget buildListViewPosts() {
    return Observer(builder: (_) {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: _viewModel.posts.length,
        itemBuilder: (context, index) => buildListTileCard(index),
      );
    });
  }

  ListTile buildListTileCard(int index) {
    return ListTile(
      title: Text(_viewModel.posts[index].title ?? ''),
      subtitle: Text(_viewModel.posts[index].body ?? ''),
      trailing: Text(_viewModel.posts[index].userId.toString()),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(appbarName),
      leading: Observer(builder: (_) {
        return Visibility(
          visible: _viewModel.isServiseReuquestLoading,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      }),
    );
  }
}
