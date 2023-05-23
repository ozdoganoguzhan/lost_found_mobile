import 'package:esya_app_mobile/context/ThemeContext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 250,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Column(
          children: [
            Text(
              "Settings",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Consumer<ThemeContext>(builder: (context, themeNotifier, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Theme"),
                  Row(
                    children: [
                      Text("Light"),
                      Switch(
                          value: themeNotifier.isDark,
                          activeColor: Colors.amber,
                          inactiveTrackColor: Colors.blue,
                          onChanged: (value) {
                            themeNotifier.isDark = !themeNotifier.isDark;
                          }),
                      Text("Dark"),
                    ],
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
