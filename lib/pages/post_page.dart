import 'package:esya_app_mobile/api/index.dart';
import 'package:esya_app_mobile/api/models.dart';
import 'package:esya_app_mobile/context/PageIndexes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class PostPage extends StatelessWidget {
  final int postId;
  final Function(int) changePage;
  const PostPage({
    super.key,
    required this.postId,
    required this.changePage,
  });

  Future<Post?> getPost() async {
    return await fetchPostById(postId);
  }

  Future<User?> getUser(int userId) async {
    return await fetchUserById(userId);
  }

  void callPostOwner(String phoneNumber) async {
    var url = Uri.parse("tel:+90$phoneNumber");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: getPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            Post post = snapshot.data!;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    color: Colors.black,
                    child: Image(
                      image: AssetImage("assets/posts/${post.imageUrl}"),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  post.title,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    Text(
                                      post.city,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Açıklama",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(post.text),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "Adres: ",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(post.address),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: FutureBuilder(
                        future: getUser(snapshot.data!.userId),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                                  ConnectionState.done &&
                              userSnapshot.hasData) {
                            User user = userSnapshot.data!;
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 160,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                                "assets/users/${userSnapshot.data!.profilePicture}"),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                                "${userSnapshot.data!.firstName}"),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                child: Text("View Profile"),
                                                onPressed: () {
                                                  changePage(userSnapshot
                                                      .data!.userId);
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      InkWell(
                                        onTap: () =>
                                            callPostOwner(user.phoneNumber),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.phone,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "+90${user.phoneNumber}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.merge(TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (userSnapshot.hasError)
                            return Text("ERROR");
                          else
                            return CircularProgressIndicator();
                        }),
                  ),
                  Container(
                    height: 60,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
