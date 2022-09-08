import 'package:flutter/material.dart';
import 'package:grapstore/lib/session.dart';

class Signup extends StatefulWidget {
  final Function _submit;
  final Function _verify;
  final Function _clear;
  final Function _resend;
  const Signup(this._submit, this._verify, this._clear, this._resend,
      {Key? key})
      : super(key: key);

  @override
  State<Signup> createState() =>
      _SignupState(_submit, _verify, _clear, _resend);
}

class _SignupState extends State<Signup> {
  final Widget divider = const Divider(
    height: 16,
    color: Colors.transparent,
  );
  final Widget verticalDivider = const VerticalDivider(
    width: 16.0,
    color: Colors.transparent,
  );

  Function _submit;
  Function _verify;
  Function _clear;
  Function _resend;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _email;
  Object? _country;
  String? _password;
  String? _confirmPassword;

  String alertText = '';
  bool isVisibleAlert = false;
  Color alertColor = Colors.transparent;

  _SignupState(this._submit, this._verify, this._clear, this._resend);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: isVisibleAlert,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(150, 0, 0, 0),
                      border: Border.all(
                        width: 0.5,
                        color: alertColor,
                      )),
                  child: Text(
                    alertText,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: alertColor),
                  ),
                ),
              ),
              Wrap(
                children: [
                  Container(
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onSaved: (value) {
                                    _firstName = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required field';
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'First Name',
                                  ),
                                ),
                              ),
                              verticalDivider,
                              Expanded(
                                child: TextFormField(
                                  onSaved: (value) {
                                    _lastName = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required field';
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Last Name',
                                  ),
                                ),
                              )
                            ],
                          ),
                          divider,
                          TextFormField(
                            onSaved: (value) {
                              _email = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required field';
                              }

                              if (!RegExp(
                                      '^[a-z0-9-_\.]*@[a-z0-9-_\.]*\.[a-z]*')
                                  .hasMatch(value)) {
                                return 'Invalid email';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                            ),
                          ),
                          divider,
                          DropdownButtonFormField(
                            hint: const Text('Country'),
                            isExpanded: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
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
                            onSaved: (value) {
                              _country = value;
                            },
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null) {
                                return 'Required Field';
                              }
                            },
                          ),
                          divider,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onSaved: (value) {
                                    _password = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required field';
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                              verticalDivider,
                              Expanded(
                                child: TextFormField(
                                  onSaved: (value) {
                                    _confirmPassword = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required field';
                                    }

                                    if (_password != _confirmPassword) {
                                      return 'Password doesn\'t match';
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
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
                                  onPressed: () async {
                                    await _clear();
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(
                                      const Size.fromHeight(50),
                                    ),
                                  ),
                                  child: Text(
                                    'Later',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              verticalDivider,
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    _formKey.currentState!.save();
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    List status = await _submit(
                                      firstName: _firstName,
                                      lastName: _lastName,
                                      email: _email,
                                      country: _country,
                                      password: _password,
                                    );
                                    if (status[0] == 0 || status[0] == 2) {
                                      bool rep = true;
                                      List res = [];
                                      List res2 = [null, null, null];
                                      while (rep) {
                                        res = await verifyEmailDialogue(
                                            _resend, res2[1] ?? status[1]);

                                        if (res[0]) {
                                          res2 = await _verify(res[1]);
                                          if (res2[0] == 0) {
                                            rep = false;
                                          }
                                        } else {
                                          rep = res[0];
                                        }
                                      }
                                    } else {
                                      setState(() {
                                        isVisibleAlert = true;
                                        alertColor = status[2];
                                        alertText = status[1];
                                      });
                                    }
                                  },
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  verifyEmailDialogue<String>(resend, msg) async {
    TextEditingController vcode = TextEditingController();
    return showDialog(
      context: context,
      builder: (builder) {
        return Wrap(
          children: [
            AlertDialog(
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(msg),
                  ),
                  TextField(
                    controller: vcode,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration:
                        const InputDecoration(hintText: 'Verification Code'),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop([false, '']);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await resend();
                  },
                  child: const Text('Resend'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop([true, vcode.text]);
                  },
                  child: const Text('Verify'),
                )
              ],
            )
          ],
        );
      },
    );
  }
}

class Login extends StatelessWidget {
  final Widget divider = const Divider(
    height: 16,
    color: Colors.transparent,
  );
  final Widget verticalDivider = const VerticalDivider(
    width: 16.0,
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
            child: Wrap(
              children: [
                Container(
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
                      Text(
                        'Welcome back',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      divider,
                      TextField(
                        controller: _user,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                        ),
                      ),
                      divider,
                      TextField(
                        controller: _pass,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                        ),
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          ),
                          verticalDivider,
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
                      const Divider(
                        height: 32.0,
                        thickness: 0.5,
                        color: Colors.black38,
                        indent: 5.0,
                        endIndent: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/signup'),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
