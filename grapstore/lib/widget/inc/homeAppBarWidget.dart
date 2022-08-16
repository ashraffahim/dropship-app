import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text('Home'),
      centerTitle: true,
      backgroundColor: Colors.white70,
      foregroundColor: Colors.black87,
      shadowColor: Colors.black12,
    );
  }
}
