import 'package:esya_app_mobile/api/index.dart';
import 'package:esya_app_mobile/api/models.dart';
import 'package:esya_app_mobile/context/PageIndexes.dart';
import 'package:esya_app_mobile/context/UserContext.dart';
import 'package:esya_app_mobile/pages/postcard_page/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class ViewProfilePage extends StatelessWidget {
  final int viewUser;
  final Function(PageIndexes, int) changeParentPage;
  const ViewProfilePage({
    super.key,
    required this.viewUser,
    required this.changeParentPage,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FutureBuilder(
        future: fetchUserById(viewUser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return Container(
              height: MediaQuery.of(context).size.height - 130,
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                "assets/users/${user.profilePicture}"),
                          ),
                          Text(
                            "${user.firstName} ${user.lastName}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "User Info",
                                style: textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Email: ",
                                style: textTheme.titleSmall,
                              ),
                              Text(user.email),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Phone Number:",
                                style: textTheme.titleSmall,
                              ),
                              Text("+90${user.phoneNumber}"),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Post Count:",
                                style: textTheme.titleSmall,
                              ),
                              FutureBuilder(
                                  future: fetchUserPostCount(user.userId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text("${snapshot.data}");
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "User's Posts",
                              style: textTheme.titleMedium,
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.only(bottom: 8.0),
                            child: FutureBuilder(
                                future: fetchPostsByUserId(viewUser),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    List<Post> userPosts = snapShot.data!;
                                    return Container(
                                      padding: EdgeInsets.zero,
                                      height: 164.0,
                                      child: GridView.builder(
                                          itemCount: userPosts.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                changeParentPage(
                                                    PageIndexes.postPage,
                                                    userPosts[index].postId);
                                              },
                                              child: PostCard(
                                                textTheme:
                                                    Theme.of(context).textTheme,
                                                postImage:
                                                    userPosts[index].imageUrl,
                                                postTitle:
                                                    userPosts[index].title,
                                                city: userPosts[index].city,
                                                address:
                                                    userPosts[index].address,
                                              ),
                                            );
                                          }),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height - 100,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
