import 'package:esya_app_mobile/api/index.dart';
import 'package:esya_app_mobile/api/models.dart';
import 'package:esya_app_mobile/context/UserContext.dart';
import 'package:esya_app_mobile/pages/not_logged_in.dart';
import 'package:esya_app_mobile/pages/postcard_page/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../context/PageIndexes.dart';

class MyPostsPage extends StatelessWidget {
  final Function(PageIndexes, int) changeParentPage;
  const MyPostsPage({super.key, required this.changeParentPage});

  Future<List<Post>> getUserPosts(int userId) async {
    return await fetchPostsByUserId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userNotifier, child) {
      if (userNotifier.isLoggedIn) {
        return Container(
          padding: EdgeInsets.zero,
          height: MediaQuery.of(context).size.height - 95,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "MY POSTS",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom: 8.0),
                child: FutureBuilder(
                    future: getUserPosts(userNotifier.userId),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        List<Post> userPosts = snapShot.data!;
                        return Container(
                          height: 420,
                          child: GridView.builder(
                              itemCount: userPosts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    changeParentPage(PageIndexes.postPage,
                                        userPosts[index].postId);
                                  },
                                  child: PostCard(
                                    textTheme: Theme.of(context).textTheme,
                                    postImage: userPosts[index].imageUrl,
                                    postTitle: userPosts[index].title,
                                    city: userPosts[index].city,
                                    address: userPosts[index].address,
                                  ),
                                );
                              }),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
            ],
          ),
        );
      } else {
        return const NotLoggedIn();
      }
    });
  }
}
