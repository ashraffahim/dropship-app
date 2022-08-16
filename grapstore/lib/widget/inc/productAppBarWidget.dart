import 'package:flutter/material.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: const Text('Details'),
      centerTitle: true,
      backgroundColor: Colors.white70,
      foregroundColor: Colors.black87,
      shadowColor: Colors.black12,
    );
  }
}
