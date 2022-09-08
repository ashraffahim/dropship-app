import 'package:flutter/material.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(),
      actions: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: const Icon(Icons.shopping_bag),
        )
      ],
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
      shadowColor: Colors.black12,
    );
  }
}
