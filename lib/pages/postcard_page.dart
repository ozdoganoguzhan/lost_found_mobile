import 'package:esya_app_mobile/api/index.dart';
import 'package:esya_app_mobile/context/PageIndexes.dart';
import 'package:esya_app_mobile/pages/post_page.dart';
import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../api/models.dart';
import 'postcard_page/category_bar.dart';
import 'postcard_page/post_card.dart';
import 'postcard_page/select_category.dart';

class PostCardPage extends StatefulWidget {
  final void Function(PageIndexes, int) changeParentPage;
  final void Function(PageIndexes) changePage;
  final ScrollController parentScrollController;
  const PostCardPage({
    super.key,
    required this.changeParentPage,
    required this.parentScrollController,
    required this.changePage,
  });

  @override
  State<PostCardPage> createState() => _PostCardPageState();
}

class _PostCardPageState extends State<PostCardPage> {
  ScrollPhysics physics = NeverScrollableScrollPhysics();
  ScrollController? _listViewScrollController;
  static const _pageSize = 8;
  final _pagingController = PagingController<int, Post>(firstPageKey: 0);
  String _selectedCategory = "none";
  bool _selectingCategory = false;
  void setSelectingCategory(bool newSC) {
    setState(() {
      _selectingCategory = newSC;
    });
  }

  void setSelectedCategory(String newCategory) {
    setState(() {
      _selectedCategory = newCategory;
    });
  }

  void listViewScrollListener() {
    if (!mounted) return;
    print("smth");
    if (_listViewScrollController == null) return;
    if (_listViewScrollController!.offset <=
            _listViewScrollController!.position.minScrollExtent &&
        !_listViewScrollController!.position.outOfRange) {
      if (widget.parentScrollController.offset == 0) {
        widget.parentScrollController.animateTo(50,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      }
      setState(() {
        physics = NeverScrollableScrollPhysics();
      });
      print("bottom");
    }
  }

  void mainScrollListener() {
    if (!mounted) return;
    if (_listViewScrollController == null) return;
    // debugPrint("PARENT OFFSET: ${widget.parentScrollController.offset}");
    // debugPrint(
    //     "PARENT MAXSCROLL: ${widget.parentScrollController.position.maxScrollExtent}");
    if (widget.parentScrollController.offset >=
            widget.parentScrollController.position.maxScrollExtent &&
        !widget.parentScrollController.position.outOfRange) {
      setState(() {
        if (physics is NeverScrollableScrollPhysics) {
          physics = ScrollPhysics();
          // _listViewScrollController!.animateTo(
          //     _listViewScrollController!.position.maxScrollExtent - 50,
          //     duration: Duration(milliseconds: 200),
          //     curve: Curves.linear);
        }
      });
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, _selectedCategory);
    });
    _listViewScrollController = ScrollController();
    _listViewScrollController!.addListener(listViewScrollListener);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey, String selectedCategory) async {
    try {
      List<Post> newItems;
      if (selectedCategory == "none") {
        newItems = await fetchPosts(pageKey: pageKey, size: _pageSize);
      } else {
        newItems = await fetchPostsByCategory(
            pageKey: pageKey, size: _pageSize, categoryId: selectedCategory);
      }
      if (mounted) {
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<Post> _fetchPostById(int postId) async {
    return await fetchPostById(postId);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    widget.parentScrollController.addListener(mainScrollListener);
    if (_selectingCategory) {
      return SelectCategory(
        setSelectedCategory: setSelectedCategory,
        selectedCategory: _selectedCategory,
        setSelectingCategory: setSelectingCategory,
        selectingCategory: _selectingCategory,
        pagingController: _pagingController,
      );
    }
    return Center(
      child: Column(
        children: [
          CategoryBar(
            setSelectingCategory: setSelectingCategory,
            setSelectedCategory: setSelectedCategory,
          ),
          if (_selectedCategory != "none")
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("$_selectedCategory kategorisine göz atılıyor"),
                  GestureDetector(
                    onTap: () {
                      setSelectedCategory("none");
                      _pagingController.refresh();
                    },
                    child: Text(
                      "Filtreyi temizle",
                      style: textTheme.bodyMedium!.merge(
                        TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 8.0,
                    bottom: 4.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Güncel İlanlar",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      FilledButton(
                        onPressed: () {
                          widget.changePage(PageIndexes.newPostPage);
                        },
                        child: Text("New Post"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 800,
                  child: PagedGridView<int, Post>(
                    shrinkWrap: true,
                    // physics: const ClampingScrollPhysics(),
                    scrollController: _listViewScrollController,
                    physics: physics,
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (context, item, index) => GestureDetector(
                        onTap: () {
                          widget.changeParentPage(
                              PageIndexes.postPage, item.postId);
                        },
                        child: PostCard(
                          textTheme: textTheme,
                          postImage: item.imageUrl,
                          postTitle: item.title,
                          city: item.city,
                          address: item.address,
                        ),
                      ),
                      firstPageErrorIndicatorBuilder: (context) =>
                          const Text("No posts found."),
                      noMoreItemsIndicatorBuilder: (context) =>
                          const Text("This is the end of Posts"),
                      noItemsFoundIndicatorBuilder: (context) =>
                          const Text("No items found"),
                      newPageErrorIndicatorBuilder: (context) =>
                          const Text("New page error"),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 2.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
