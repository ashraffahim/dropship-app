import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  final Widget divider = const Divider(
    height: 16,
    color: Colors.transparent,
  );

  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(1.0, 1.0),
            stops: [0.3, 0.3, 0.3, 0.7, 0.7, 1.0],
            colors: [
              Color.fromRGBO(106, 90, 205, 1),
              Color.fromRGBO(106, 90, 205, 1),
              Colors.white,
              Colors.white,
              Color.fromRGBO(106, 90, 205, 1),
              Color.fromRGBO(106, 90, 205, 1),
            ],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              height: 400,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      spreadRadius: -5,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'First Name',
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: 16.0,
                        color: Colors.transparent,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Last Name'),
                        ),
                      )
                    ],
                  ),
                  divider,
                  const TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email'),
                  ),
                  divider,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.black87,
                        width: 0.1,
                      ),
                    ),
                    child: DropdownButton(
                      hint: const Text('Country'),
                      isExpanded: true,
                      underline: Container(),
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
                      onChanged: (value) {},
                    ),
                  ),
                  divider,
                  Row(
                    children: const [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password'),
                        ),
                      ),
                      VerticalDivider(
                        width: 16.0,
                        color: Colors.transparent,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Confirm Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                  divider,
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              const Size.fromHeight(50),
                            ),
                          ),
                          child: Text(
                            'Later',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 16.0,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            fixedSize: MaterialStateProperty.all(
                              const Size.fromHeight(50),
                            ),
                          ),
                          child: const Text(
                            'Signup',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  final Widget divider = const Divider(
    height: 16,
    color: Colors.transparent,
  );

  final Function _submit;
  final _user = TextEditingController();
  final _pass = TextEditingController();

  Login(this._submit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/login-blob.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      spreadRadius: -5,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _user,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email'),
                  ),
                  divider,
                  TextField(
                    controller: _pass,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Password'),
                  ),
                  divider,
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              const Size.fromHeight(50),
                            ),
                          ),
                          child: Text(
                            'Later',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 16.0,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () => _submit(_user.text, _pass.text),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.primary),
                            fixedSize: MaterialStateProperty.all(
                              const Size.fromHeight(50),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 32.0,
                    thickness: 0.5,
                    color: Colors.black38,
                    indent: 5.0,
                    endIndent: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/signup'),
                        child: Text('Sign Up'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
