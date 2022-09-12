import 'package:flutter/material.dart';

import './instance/home.dart';
import './instance/product.dart';
import './instance/auth.dart';
import './instance/browser.dart';

void main() => runApp(
      MaterialApp(
        title: 'Grapstore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Rubik',
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
            ),
            headline5: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
            ),
            bodyText2: TextStyle(
              color: Color.fromARGB(225, 150, 150, 150),
            ),
          ),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromARGB(255, 31, 70, 144),
            onPrimary: Color.fromARGB(255, 255, 255, 255),
            secondary: Color.fromARGB(255, 0, 0, 0),
            onSecondary: Color.fromARGB(255, 255, 255, 255),
            error: Color.fromARGB(255, 255, 0, 0),
            onError: Color.fromARGB(255, 255, 255, 255),
            background: Color.fromARGB(255, 255, 255, 255),
            onBackground: Color.fromARGB(255, 31, 70, 144),
            surface: Color.fromARGB(255, 250, 250, 250),
            onSurface: Color.fromARGB(255, 0, 0, 0),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 0,
            ),
            constraints: BoxConstraints(maxHeight: 64.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black87,
                width: 0.1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
        ),
        initialRoute: '/browser',
        routes: {
          '/': (BuildContext context) => const Home(),
          '/product': (BuildContext context) =>
              Product(ModalRoute.of(context)!.settings.arguments.toString()),
          '/login': (BuildContext context) => Auth('login'),
          '/signup': (BuildContext context) => Auth('signup'),
          '/browser': (BuildContext context) => Browser(),
        },
      ),
    );
