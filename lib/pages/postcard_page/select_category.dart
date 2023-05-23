import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../api/models.dart' as models;

class SelectCategory extends StatelessWidget {
  final Function setSelectedCategory;
  final String selectedCategory;
  final Function setSelectingCategory;
  final bool selectingCategory;
  final PagingController pagingController;
  const SelectCategory({
    super.key,
    required this.setSelectedCategory,
    required this.selectedCategory,
    required this.setSelectingCategory,
    required this.selectingCategory,
    required this.pagingController,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    if (selectedCategory != "none" && selectedCategory != null) {
      list.add(ListTile(
        contentPadding: EdgeInsets.zero,
        leading: IconButton(
          onPressed: () {
            setSelectedCategory("none");
            setSelectingCategory(false);
          },
          icon: Icon(Icons.chevron_left),
        ),
      ));
      if (models.categories[selectedCategory] != null) {
        for (String subCategory in models.categories[selectedCategory]!) {
          list.add(ListTile(
            // shape: RoundedRectangleBorder(
            //   side: BorderSide(
            //     width: 1,
            //     color: Colors.grey,
            //   ),
            // ),
            title: Text(subCategory),
            onTap: () {
              setSelectedCategory(subCategory);
              setSelectingCategory(false);
              pagingController.refresh();
            },
          ));
          list.add(Divider());
        }
      }
    }

    return WillPopScope(
      onWillPop: () async {
        debugPrint("ALT POP");
        if (selectingCategory) {
          setSelectingCategory(false);
          return false;
        } else {
          return true;
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: list,
        ),
      ),
    );
  }
}
