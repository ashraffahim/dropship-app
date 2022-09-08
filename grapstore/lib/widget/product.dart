import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grapstore/env/config.dart';

import '../lib/cart.dart';

class ProductDetailsWidget extends StatefulWidget {
  final Map _data;
  final items = <Widget>[];
  bool isLoaded = false;
  int indicatorIndex = 0;
  List indicatorList = [];
  ProductDetailsWidget(this._data, this.isLoaded, {Key? key})
      : super(key: key) {
    if (isLoaded) {
      for (var i = 0; i < _data['p_image']; i++) {
        items.add(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.network(
                '${Config.CDNAddr}/product/${_data["id"]}/$i.jpg'),
          ),
        );
        indicatorList.add(i);
      }
    }
  }

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.isLoaded
        ? const CircularProgressIndicator()
        : SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: widget.items,
                  options: CarouselOptions(
                    height: 400,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) =>
                        carouselPageChange(index, reason),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.indicatorList.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return AnimatedContainer(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: i == widget.indicatorIndex ? 20 : 10,
                            height: 10,
                            duration: const Duration(milliseconds: 100),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: i == widget.indicatorIndex
                                  ? Colors.black
                                  : Colors.black45,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget._data['p_name'],
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const Divider(
                        height: 10,
                        color: Colors.white,
                      ),
                      Text(
                        widget._data['p_category'],
                      ),
                      const Divider(
                        height: 10,
                        color: Colors.white,
                      ),
                      Text(
                        widget._data['p_description'],
                        style: const TextStyle(color: Colors.black54),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }

  void carouselPageChange(index, reason) {
    setState(() {
      widget.indicatorIndex = index;
    });
  }
}

class ProductDetailsBottomNavWidget extends StatelessWidget {
  final Map _data;
  bool isLoaded = false;

  ProductDetailsBottomNavWidget(this._data, this.isLoaded, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartAction cartAction = CartAction();
    return !isLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18.0)),
              border: Border.all(
                width: 1.0,
                color: Colors.black12,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _data['currency_symbol'] + _data['p_price'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[300],
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () => cartAction.addToCart(
                      id: _data['id'].toString(),
                      name: _data['p_name'],
                      currency: _data['s_currency'],
                      price: double.parse(_data['p_price']),
                      qty: 1,
                    ),
                    icon: const Icon(Icons.add),
                    iconSize: 25,
                    splashRadius: 25,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      splashFactory: InkSparkle.splashFactory,
                      fixedSize:
                          MaterialStateProperty.all(const Size.fromHeight(40)),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'BUY',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
