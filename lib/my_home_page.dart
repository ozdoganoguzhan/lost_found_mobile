import 'package:esya_app_mobile/api/index.dart';
import 'package:esya_app_mobile/context/PageIndexes.dart';
import 'package:esya_app_mobile/context/UserContext.dart';
import 'package:esya_app_mobile/pages/login_page.dart';
import 'package:esya_app_mobile/pages/my_posts_page.dart';
import 'package:esya_app_mobile/pages/new_post_page.dart';
import 'package:esya_app_mobile/pages/post_page.dart';
import 'package:esya_app_mobile/pages/postcard_page.dart';
import 'package:esya_app_mobile/pages/profile_page.dart';
import 'package:esya_app_mobile/pages/view_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'api/models.dart';
import 'bottom_navigation.dart';
import 'context/ThemeContext.dart';
import 'my_drawer.dart';
import 'pages/settings_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedPage = PageIndexes.postCardPage;
  int _bottomNavigationIndex = 0;
  int _selectedPost = 0;
  int _viewedUserId = 0;
  var _prevPage;
  ScrollController _mainScrollController = ScrollController();

  void changePageToPost(PageIndexes newPage, int postId) {
    setState(() {
      _prevPage = _selectedPage;
      _selectedPage = newPage;
      _selectedPost = postId;
    });
  }

  void viewProfile(int userId) {
    setState(() {
      _viewedUserId = userId;
      changePage(PageIndexes.viewProfile);
    });
  }

  void changePage(PageIndexes newPage) {
    setState(() {
      _prevPage = _selectedPage;
      _selectedPage = newPage;
    });
  }

  void _bottomNavigationItemTapped(int index) {
    _selectedPage = PageIndexes.values.elementAt(index);
    setState(() {
      _bottomNavigationIndex = index;
    });
  }

  Future<User> getUser(int userId) async {
    return await fetchUserById(userId);
  }

  Future<bool> _onWillPop() async {
    debugPrint("DIŞ POP");
    if (_selectedPage == PageIndexes.postCardPage) {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: new Text("Exit App"),
              content: new Text("Are you sure?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text("Yes"),
                )
              ],
            ),
          )) ??
          false;
    } else {
      setState(() {
        _selectedPage = _prevPage;
        if (0 <= _selectedPage.index && _selectedPage.index <= 2) {
          _bottomNavigationIndex = _prevPage.index;
        }
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (_selectedPage) {
      case PageIndexes.postCardPage:
        page = PostCardPage(
          changeParentPage: changePageToPost,
          parentScrollController: _mainScrollController,
          changePage: changePage,
        );
        break;
      case PageIndexes.postPage:
        page = PostPage(
          postId: _selectedPost,
          changePage: viewProfile,
        );
        break;
      case PageIndexes.loginPage:
        page = LoginPage(
          changePage: changePage,
        );
        break;
      case PageIndexes.profilePage:
        page = ProfilePage(
          changePage: changePage,
        );
        break;
      case PageIndexes.newPostPage:
        page = NewPostPage();
        break;
      case PageIndexes.settingsPage:
        page = const SettingsPage();
        break;
      case PageIndexes.viewProfile:
        page = ViewProfilePage(
          viewUser: _viewedUserId,
          changeParentPage: changePageToPost,
        );
        break;
      case PageIndexes.myPostsPage:
        page = MyPostsPage(changeParentPage: changePageToPost);
        break;
      default:
        throw UnimplementedError("no page");
    }
    return LayoutBuilder(builder: (context, constraints) {
      List<BottomNavigationBarItem> botNavbarButtons = [];

      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          bottomNavigationBar: BottomNavigation(
              bottomNavigationIndex: _bottomNavigationIndex,
              bottomNavigationItemTapped: _bottomNavigationItemTapped),
          drawer: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 200,
            child: MyDrawer(
              changePage: changePage,
            ),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: AppBar(
              title: const Text("LostFound"),
            ),
          ),
          body: Container(
            height: 800,
            child: SingleChildScrollView(
              controller: _mainScrollController,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Center(child: page),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
