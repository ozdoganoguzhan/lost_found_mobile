import 'package:esya_app_mobile/context/PageIndexes.dart';
import 'package:esya_app_mobile/context/ThemeContext.dart';
import 'package:esya_app_mobile/context/UserContext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  final Function(PageIndexes) changePage;
  const MyDrawer({
    super.key,
    required this.changePage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 154,
            child: DrawerHeader(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.chevron_left,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        "Menu",
                        style: Theme.of(context).primaryTextTheme.bodyLarge,
                      ),
                      Consumer<ThemeContext>(
                          builder: (context, themeNotifier, child) {
                        return IconButton(
                          onPressed: () {
                            themeNotifier.isDark = !themeNotifier.isDark;
                          },
                          icon: Icon(
                            themeNotifier.isDark
                                ? Icons.dark_mode_outlined
                                : Icons.light_mode,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        );
                      }),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<UserContext>(
                      builder: ((context, user, child) {
                        if (user.isLoggedIn) {
                          return Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/users/${user.profilePicture}"),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    changePage(PageIndexes.profilePage);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${user.firstName}",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyMedium,
                                      maxLines: 2,
                                      overflow: TextOverflow.fade,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  changePage(PageIndexes.profilePage);
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_right,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              )
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              FilledButton(
                                style: ButtonStyle(
                                  elevation: MaterialStatePropertyAll(5.0),
                                ),
                                onPressed: () {
                                  changePage(PageIndexes.loginPage);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Login",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyMedium,
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Posts'),
            onTap: () {
              changePage(PageIndexes.postCardPage);
              Navigator.pop(context);
            },
          ),
          const Divider(
            indent: 4.0,
            endIndent: 4.0,
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              changePage(PageIndexes.settingsPage);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
