import 'dart:io';
import 'dart:ui';
import 'package:esya_app_mobile/api/index.dart';
import 'package:esya_app_mobile/context/PageIndexes.dart';
import 'package:esya_app_mobile/context/UserContext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/models.dart';

class LoginPage extends StatefulWidget {
  final Function(PageIndexes) changePage;
  LoginPage({super.key, required this.changePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String _emailInput = "";
  String _passwordInput = "";

  bool inputValidator() {
    return true;
  }

  Future<User?> getUserByEmail(String email) async {
    return await fetchUserByEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 100,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Text(
              "Login",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      onChanged: (value) {
                        if (inputValidator()) {
                          setState(() {
                            _emailInput = value;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      onChanged: (value) {
                        debugPrint("PASSWORD SUBMIT");
                        if (inputValidator()) {
                          setState(() {
                            _passwordInput = value;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Consumer<UserContext>(
                      builder: (context, user, child) {
                        return OutlinedButton(
                          onPressed: () {
                            if (inputValidator()) {
                              try {
                                debugPrint(_emailInput);
                                getUserByEmail("oguzhanemre.ozdogan@gmail.com")
                                    .then((value) {
                                  if (value != null) {
                                    user.setUser(value);
                                  } else {
                                    throw Error();
                                  }
                                });
                                widget.changePage(PageIndexes.postCardPage);
                              } catch (error) {
                                debugPrint("User not found. $error");
                              }
                            }
                          },
                          child: const Text("Login"),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        launchUrl(Uri.https('pbs.twimg.com',
                            '/profile_images/1877136922/1329510531_400x400.jpg'));
                      },
                      child: Text("Don't have an account? Sign up here."),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
