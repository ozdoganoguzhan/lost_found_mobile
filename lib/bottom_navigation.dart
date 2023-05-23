import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BottomNavigation extends StatelessWidget {
  final void Function(int) bottomNavigationItemTapped;
  int bottomNavigationIndex;
  BottomNavigation({
    super.key,
    required this.bottomNavigationIndex,
    required this.bottomNavigationItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: 'Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: 'New Post',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.health_and_safety,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: 'My Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: bottomNavigationIndex,
      selectedItemColor: Colors.indigo,
      onTap: bottomNavigationItemTapped,
    );
  }
}
