import 'dart:io';

import 'package:esya_app_mobile/api/models.dart';
import 'package:esya_app_mobile/context/UserContext.dart';
import 'package:esya_app_mobile/pages/not_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../api/index.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  XFile? image;
  String _postTitle = "";
  String _postAddress = "";
  String _postCity = "";
  String _postText = "";
  bool _postIsFound = false;
  String _postImageUrl = "kedi.png";
  String _postCategoryId = "";

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void postNewPost(int userId) async {
    final _postDate = DateTime.now();

    postPost({
      "title": _postTitle,
      "text": _postText,
      "address": _postAddress,
      "categoryId": _postCategoryId,
      "city": _postCity,
      "userId": userId.toString(),
      "isFound": _postIsFound.toString(),
      "imageUrl": _postImageUrl,
      "date": _postDate.toString(),
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userNotifier, child) {
      if (userNotifier.isLoggedIn) {
        return Container(
          height: MediaQuery.of(context).size.height + 300,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _postTitle = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Title"),
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _postAddress = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Address"),
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _postCity = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("City"),
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _postText = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Text"),
                        ),
                      ),
                      DropdownButton<String>(
                        icon: const Icon(Icons.arrow_downward),
                        value: "electronic-subcategory-computer",
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            _postCategoryId = value!;
                          });
                        },
                        items: [
                          "electronic-subcategory-computer",
                          "pet-subcategory-bird"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      FilledButton(
                        onPressed: () {
                          myAlert();
                        },
                        child: Text("Upload Image:"),
                      ),
                      image != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  //to show image, you type like this.
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                ),
                              ),
                            )
                          : Text(
                              "No Image",
                              style: TextStyle(fontSize: 20),
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      } else {
        return NotLoggedIn();
      }
    });
  }
}
