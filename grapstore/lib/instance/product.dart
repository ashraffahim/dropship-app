import 'package:flutter/material.dart';
import 'package:grapstore/widget/product.dart';

import '../model/product.dart';
import '../widget/inc/productAppBarWidget.dart';

class Product extends StatefulWidget {
  final int id;

  const Product(this.id, {Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  Map _data = {};
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProductDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ProductAppBar(),
      ),
      body: ProductDetailsWidget(_data, isLoaded),
      bottomNavigationBar: ProductDetailsBottomNavWidget(_data, isLoaded),
    );
  }

  void loadProductDetails(int id) async {
    ProductModel productModel = ProductModel();
    _data = await productModel.details(id) as Map;
    setState(() {
      isLoaded = true;
    });
  }
}
