import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/inc/bottomNavWidget.dart';
import '../widget/inc/homeAppBarWidget.dart';
import '../widget/home.dart';
import '../model/home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _data = [];
  bool isLoaded = false;
  int navIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(),
      ),
      body: HomeWidget(_data, isLoaded),
      bottomNavigationBar: BottomNavWidget(navIndex, bottomNavigationTapped),
    );
  }

  void loadHome() async {
    HomeModel homeModel = HomeModel();
    _data = await homeModel.feed();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoaded = true;
    });
  }

  void bottomNavigationTapped(context, int index) {
    Map nav = {0: '/', 3: '/login'};
    for (var e in nav.entries) {
      if (e.key == index && ModalRoute.of(context)?.settings.name != e.value) {
        Navigator.pushNamed(context, e.value);
        break;
      }
    }
    setState(() {
      navIndex = index;
    });
  }
}
