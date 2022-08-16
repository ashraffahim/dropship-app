import '../lib/session.dart';

class AuthModel {
  Future<Map> login(String user, String pass) async {
    Session session = Session();
    Map data = await session.post('/login', {'email': user, 'password': pass});

    return data;
  }
}
