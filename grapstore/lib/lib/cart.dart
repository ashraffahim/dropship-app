import 'package:grapstore/lib/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartAction {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void addToCart(
      {String? id,
      String? name,
      String? currency,
      double? price,
      int qty = 1}) async {
    SharedPreferences prefs = await _prefs;
    if (!prefs.getKeys().contains('p$id')) {
      prefs.setStringList(
        'p$id',
        [
          name.toString(),
          currency.toString(),
          price.toString(),
          qty.toString()
        ],
      );
    }
  }

  void removeFromCart(id) async {
    SharedPreferences prefs = await _prefs;
    if (prefs.getKeys().contains('p$id')) {
      prefs.remove('p$id');
    }
  }

  void addQty(id, qty) async {
    SharedPreferences prefs = await _prefs;

    List<String>? items = prefs.getStringList('p$id');
    items?[3] = qty.toString();

    prefs.setStringList('p$id', items!);
  }

  void emptyCart() async {
    SharedPreferences prefs = await _prefs;
    Set sps = prefs.getKeys();

    for (var k in sps) {
      if (RegExp('p[0-9]+').hasMatch(k)) {
        prefs.remove(k);
      }
    }
  }

  Future<double> serviceCharge() async {
    Session session = Session();
    Map res = await session.get('/cart/service-charge');
    return double.parse(res['data']);
  }

  Future<dynamic> createInvoice(Map data) async {
    Session session = Session();
    Map res = await session.post('/checkout/order', data);
    return res;
  }
}
