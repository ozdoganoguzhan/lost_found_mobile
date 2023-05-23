import 'dart:io';
import 'package:esya_app_mobile/context/ThemeContext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'my_home_page.dart';
import "context/UserContext.dart";

const routeHome = "/";
const routePostCards = "/postcards";
const routePost = "/post";

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeContext>(
      create: (context) => ThemeContext(),
      child: Consumer<ThemeContext>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeNotifier.isDark
                ? ThemeData(brightness: Brightness.dark)
                : ThemeData(
                    primarySwatch: Colors.indigo,
                    brightness: Brightness.light,
                    primaryColor: Colors.indigo[800],
                  ),
            locale: const Locale.fromSubtags(languageCode: "tr"),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("en"),
              Locale("tr"),
            ],
            home: ChangeNotifierProvider(
                create: (context) => UserContext(),
                child: MyHomePage(title: 'Flutter Demo Home Page')),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
