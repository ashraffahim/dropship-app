import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  double serviceCharge = 0.0;
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
      calculateTotal();
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
                    if (selectedCurr == '' ||
                        selectedCurr == _items[index][1]) {
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
                                          style:
                                              const TextStyle(fontSize: 24.0),
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
                    } else {
                      return Container();
                    }
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
                      left: currSelectorPos(),
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
                          setState(() {
                            selectedCurr = 'AED';
                          });
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
                          setState(() {
                            selectedCurr = 'BDT';
                          });
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => checkout(context),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(3.0),
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

  currSelectorPos() {
    switch (selectedCurr) {
      case 'AED':
        return -8.0;
      case 'BDT':
        return (MediaQuery.of(context).size.width - 16.0) / 2.0;
      case '':
        return MediaQuery.of(context).size.width;
    }
  }

  loadCartData() async {
    SharedPreferences prefs = await _prefs;
    Set sps = prefs.getKeys();
    String? id = '';

    // Service charge percentage
    serviceCharge = await cartAction.serviceCharge();

    // Clear prev data
    _items = [];
    _itemCount = 0;

    List items = [];
    List<String> curr = [];

    for (var k in sps) {
      // Regex to isolate id
      if (RegExp('p[0-9]+').hasMatch(k)) {
        id = RegExp('p([0-9]+)').firstMatch(k)![1];
        items = prefs.getStringList(k)!;

        // Show cart items by selected currency
        _itemCount++;
        items.add(id!);
        _items.add(items);

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

    return true;
  }

  calculateTotal() {
    _total = {'qty': 0, 'amount': 0, 'discount': 0, 'service': 0, 'payable': 0};

    for (int i = 0; i < _items.length; i++) {
      // Regex to isolate id
      if (selectedCurr == '' || selectedCurr == _items[i][1]) {
        // Set totals
        _total['qty'] = (_total['qty'] as int) + int.parse(_items[i][3]);
        _total['amount'] = (_total['amount']) +
            (double.parse(_items[i][2]) * double.parse(_items[i][3]));
        _total['discount'] = 0.0;
        _total['service'] = _total['amount'] * serviceCharge;
        _total['payable'] =
            _total['amount'] + _total['service'] - _total['discount'];
      }
    }
  }

  Future<void> checkout(context) async {
    // Check logged in
    SharedPreferences prefs = await _prefs;
    if (prefs.getStringList('user') == null) {
      Navigator.of(context).pushNamed('/login');
    } else {
      // Get shipping address
      GlobalKey<FormState> formKey = GlobalKey<FormState>();
      var data = await showDialog(
        context: context,
        builder: (builder) {
          Widget divider = const Divider(
            height: 8.0,
            color: Colors.transparent,
          );
          Map address = {};

          return Center(
            child: SingleChildScrollView(
              child: Dialog(
                child: Wrap(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipping',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            const Divider(
                              height: 16.0,
                              color: Colors.transparent,
                            ),
                            TextFormField(
                              onSaved: (value) {
                                address['address'] = value;
                              },
                              keyboardType: TextInputType.streetAddress,
                              decoration: const InputDecoration(
                                  hintText: 'Address line'),
                            ),
                            divider,
                            TextFormField(
                              onSaved: (value) {
                                address['address_2'] = value;
                              },
                              keyboardType: TextInputType.streetAddress,
                              decoration: const InputDecoration(
                                  hintText: 'Address line 2'),
                            ),
                            divider,
                            DropdownButtonFormField(
                              onChanged: (value) {},
                              onSaved: (value) {
                                address['country'] = value.toString();
                              },
                              decoration:
                                  const InputDecoration(hintText: 'Country'),
                              items: const [
                                DropdownMenuItem(
                                  value: 'BD',
                                  child: Text('Bangladesh'),
                                ),
                                DropdownMenuItem(
                                  value: 'AE',
                                  child: Text('United Arab Emirates'),
                                )
                              ],
                            ),
                            divider,
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    onSaved: (value) {
                                      address['city'] = value;
                                    },
                                    decoration:
                                        const InputDecoration(hintText: 'City'),
                                  ),
                                ),
                                const VerticalDivider(
                                  width: 8.0,
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onSaved: (value) {
                                      address['zip'] = value;
                                    },
                                    decoration:
                                        const InputDecoration(hintText: 'ZIP'),
                                  ),
                                ),
                              ],
                            ),
                            divider,
                            TextFormField(
                              onSaved: (value) {
                                address['phone'] = value;
                              },
                              keyboardType: TextInputType.phone,
                              decoration:
                                  const InputDecoration(hintText: 'Phone'),
                            ),
                            divider,
                            TextFormField(
                              onSaved: (value) {
                                address['email'] = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                            ),
                            divider,
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                        const Size.fromHeight(50.0),
                                      ),
                                    ),
                                    child: const Text('Cancel'),
                                  ),
                                ),
                                const VerticalDivider(
                                  width: 8.0,
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      formKey.currentState!.save();
                                      Navigator.of(context).pop(address);
                                    },
                                    style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                        const Size.fromHeight(50.0),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Theme.of(context).colorScheme.primary,
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                        Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                    child: const Text('Confirm'),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );

      if (data != false) {
        // Serialize data
        data['c'] = selectedCurr;
        data['items'] = '';
        for (int i = 0; i < _items.length; i++) {
          data['items'] += (i != 0 ? ',' : '') + _items[i][4];
          data['qty_${_items[i][4]}'] = _items[i][3];
        }

        // Create invoice
        Map id = await cartAction.createInvoice(data);

        // Redirect to browser for payment
        Navigator.pushNamed(context, '/browser', arguments: id['id']);
      }
    }
  }
}
