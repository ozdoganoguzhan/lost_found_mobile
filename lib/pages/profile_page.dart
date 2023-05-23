import 'package:esya_app_mobile/api/index.dart';
import 'package:esya_app_mobile/context/PageIndexes.dart';
import 'package:esya_app_mobile/context/UserContext.dart';
import 'package:esya_app_mobile/pages/not_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final Function(PageIndexes) changePage;
  const ProfilePage({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<UserContext>(builder: (context, userNotifier, child) {
      if (userNotifier.isLoggedIn) {
        return Container(
          height: MediaQuery.of(context).size.height - 130,
          child: Consumer<UserContext>(builder: (context, userNotifier, child) {
            return Column(
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
                              "assets/users/${userNotifier.profilePicture}"),
                        ),
                        Text(
                          "${userNotifier.firstName} ${userNotifier.lastName}",
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
                            Text(userNotifier.email),
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
                            Text("+90${userNotifier.phoneNumber}"),
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
                                future: fetchUserPostCount(userNotifier.userId),
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
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "User's Posts",
                            style: textTheme.titleMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              changePage(PageIndexes.myPostsPage);
                            },
                            child: Text("See your posts"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      } else {
        return NotLoggedIn();
      }
    });
  }
}
