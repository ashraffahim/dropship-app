import 'package:flutter/material.dart';

class BottomNavWidget extends StatelessWidget {
  var index;
  final onTap;

  BottomNavWidget(this.index, this.onTap);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.black45,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      currentIndex: index,
      onTap: (index) => onTap(context, index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_rounded),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        )
      ],
    );
  }
}
