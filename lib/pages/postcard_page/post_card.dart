import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String postTitle;
  final String postImage;
  final TextTheme textTheme;
  final String city;
  final String address;

  const PostCard({
    super.key,
    required this.textTheme,
    required this.postTitle,
    required this.postImage,
    required this.city,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image(
              image: AssetImage("assets/posts/$postImage"),
              width: 192,
              height: 108,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postTitle,
                    style: textTheme.bodySmall,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  const Divider(),
                  RichText(
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: "$city, $address",
                          style: textTheme.labelMedium?.merge(TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
