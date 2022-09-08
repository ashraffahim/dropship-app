import 'package:flutter/material.dart';
import 'package:grapstore/env/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../lib/cart.dart';

class CartWidget extends StatefulWidget {
  CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  CartAction cartAction = CartAction();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int _itemCount = 0;
  List _items = [];
  Map<String, dynamic> _total = {
    'qty': 0,
    'amount': 0.0,
    'discount': 0.0,
    'service': 0.0,
    'payable': 0.0
  };
  bool showCurrencyOption = false;
  String selectedCurr = '';

  bool isLoaded = false;

  final GlobalKey<FormState> _cartFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadCartData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Cart',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Form(
                key: _cartFormKey,
                child: ListView.builder(
                  itemCount: _itemCount,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(index.toString()),
                      onDismissed: (direction) async {
                        cartAction.removeFromCart(_items[index][4]);
                        _items.removeAt(index);
                        loadCartData();
                      },
                      background: Container(
                        margin: const EdgeInsets.all(8.0),
                        alignment: AlignmentDirectional.centerEnd,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Icon(
                            Icons.delete_outline,
                            color: Theme.of(context).colorScheme.onError,
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(8.0)),
                              child: Image.network(
                                '${Config.CDNAddr}/product/${_items[index][4]}/0.jpg',
                                width: 70,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${_items[index][0]}',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 24.0,
                                          ),
                                        ),
                                        Text(
                                          '${_items[index][1] + _items[index][2]}',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: '${_items[index][3]}',
                                        textAlign: TextAlign.end,
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(fontSize: 24.0),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          fillColor: Colors.transparent,
                                        ),
                                        onChanged: (value) {
                                          cartAction.addQty(
                                            _items[index][4],
                                            value,
                                          );
                                          loadCartData();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: showCurrencyOption,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedPositioned(
                      top: -8,
                      left: selectedCurr == 'AED'
                          ? -8
                          : (MediaQuery.of(context).size.width - 32) / 2,
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 16) / 2,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 32) / 2,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          selectedCurr = 'AED';
                          loadCartData();
                        },
                        child: Text(
                          'AED',
                          style: selectedCurr == 'AED'
                              ? TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold)
                              : const TextStyle(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: (MediaQuery.of(context).size.width - 32) / 2,
                      child: InkWell(
                        onTap: () {
                          selectedCurr = 'BDT';
                          loadCartData();
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 16) / 2,
                          alignment: Alignment.center,
                          child: Text(
                            'BDT',
                            style: selectedCurr == 'BDT'
                                ? TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold)
                                : const TextStyle(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth()
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Qty',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          _total['qty'].toString(),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Amount',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          _total['amount'].toString(),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Discount',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          _total['discount'].toString(),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Service',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          _total['service'].toString(),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Payable',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          _total['payable'].toString(),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const ContinuousRectangleBorder(),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                      fixedSize: MaterialStateProperty.all(
                        const Size.fromHeight(50.0),
                      ),
                    ),
                    child: Text(
                      'CHECKOUT',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return const Center(
        child: Text('Loading...'),
      );
    }
  }

  void loadCartData() async {
    SharedPreferences prefs = await _prefs;
    Set sps = prefs.getKeys();
    String? id = '';

    // Clear prev data
    _items = [];
    _itemCount = 0;
    _total = {'qty': 0, 'amount': 0, 'discount': 0, 'service': 0, 'payable': 0};

    List items = [];
    List<String> curr = [];

    for (var k in sps) {
      // Regex to isolate id
      if (RegExp('p[0-9]+').hasMatch(k)) {
        id = RegExp('p([0-9]+)').firstMatch(k)![1];
        items = prefs.getStringList(k)!;

        // Show cart items by selected currency
        if (selectedCurr == '' || selectedCurr == items[1]) {
          _itemCount++;
          items.add(id!);
          _items.add(items);

          // Set totals
          _total['qty'] = (_total['qty'] as int) + int.parse(items[3]);
          _total['amount'] = (_total['amount']) +
              (double.parse(items[2]) * double.parse(items[3]));
          _total['discount'] = 0.0;
          _total['service'] = 0.0;
          _total['payable'] =
              _total['amount'] + _total['service'] + _total['payable'];
        }

        // Isolate currencies
        if (!curr.contains(items[1])) {
          curr.add(items[1]);
        }
        if (curr.length > 1) {
          showCurrencyOption = true;
        }
      }
    }

    setState(() {
      isLoaded = true;
    });
  }
}
