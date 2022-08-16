import '../lib/session.dart';

class ProductModel {
  Future details(int id) async {
    Session session = Session();
    return await session.get('/product/details/$id');
  }
}
