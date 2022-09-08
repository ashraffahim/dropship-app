import '../lib/session.dart';

class AuthModel {
  Session session = Session();
  Future<Map> signup(
      {required String firstName,
      required String lastName,
      required String email,
      required String country,
      required String password}) async {
    var res = await session.post(
      '/signup',
      {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'country': country,
        'password': password
      },
    );
    return res;
  }

  Future<Map> login(String user, String pass) async {
    Map data = await session.post('/login', {'email': user, 'password': pass});

    return data;
  }

  Future<Map> verify(code) async {
    Map data = await session.post('/signup', {'vcode': code});
    return data;
  }

  Future<Map> clear() async {
    Map data = await session.get('/signup/cleartmp');
    return data;
  }

  Future<Map> resend() async {
    Map data = await session.get('/signup/resend');
    return data;
  }
}
