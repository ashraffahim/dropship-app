import '../lib/session.dart';

class HomeModel {
  Future feed() async {
    Session session = Session();
    return await session.get('/');
  }
}
