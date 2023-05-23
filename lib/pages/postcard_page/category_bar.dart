import 'package:esya_app_mobile/api/index.dart';
import 'package:esya_app_mobile/api/models.dart';
import 'package:flutter/material.dart';

class CategoryBar extends StatelessWidget {
  final Function setSelectingCategory;
  final Function setSelectedCategory;
  const CategoryBar({
    super.key,
    required this.setSelectingCategory,
    required this.setSelectedCategory,
  });

  Future<List<Category>> getCategories() async {
    return await fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Kategorilere Göz At",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 100,
                    margin: EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
                    child: Column(
                      children: [
                        IconButton(
                          splashRadius: 30.0,
                          iconSize: 50.0,
                          onPressed: () {
                            setSelectedCategory("pet");
                            setSelectingCategory(true);
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            fill: 1.0,
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          "Evcil Hayvanlar",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
                    child: Column(
                      children: [
                        IconButton(
                          splashRadius: 30.0,
                          iconSize: 50.0,
                          onPressed: () {
                            setSelectedCategory("electronic");
                            setSelectingCategory(true);
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            fill: 1.0,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "Elektronik",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
                    child: Column(
                      children: [
                        IconButton(
                          splashRadius: 30.0,
                          iconSize: 50.0,
                          onPressed: () {
                            setSelectingCategory(true);
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            fill: 1.0,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          "Evcil Hayvanlar",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
                    child: Column(
                      children: [
                        IconButton(
                          splashRadius: 30.0,
                          iconSize: 50.0,
                          onPressed: () {
                            setSelectingCategory(true);
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            fill: 1.0,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "Evcil Hayvanlar",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
