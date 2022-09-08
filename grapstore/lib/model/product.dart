import '../lib/session.dart';

class ProductModel {
  Future details(String id) async {
    Session session = Session();
    return await session.get('/product/details/$id');
  }
}
