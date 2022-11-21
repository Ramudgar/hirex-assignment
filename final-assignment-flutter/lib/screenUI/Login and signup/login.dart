import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hirexapp/controller/auth_controller.dart';
import 'package:hirexapp/repository/user_repository.dart';
import 'package:light/light.dart';
import 'package:motion_toast/motion_toast.dart';

final List<String> imgList = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtCYBY8-6K1gwwtiBiA4dQmPq_3AM9XkIWNQ&usqp=CAU",
  'https://149695847.v2.pressablecdn.com/wp-content/uploads/2019/07/investor-banner-01.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzn9xwv7DIWkKqOGqmt7iQ8ETVODlQnfYKXg&usqp=CAU',
];

final themeMode = ValueNotifier(2);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _login() async {
    try {
      UserRepository userRepository = UserRepository();
      bool isLogin = await userRepository.login(
        email.text,
        password.text,
        role,
      );

      if (isLogin) {
        navigateToScreen(true);
      } else {
        navigateToScreen(false);
      }
    } catch (e) {
      MotionToast.error(
        description: Text("Error:${e.toString()}"),
      ).show(context);
    }
  }

  navigateToScreen(bool isLogin) async {
    if (isLogin) {
      if (role == "employee") {
        Navigator.pushReplacementNamed(context, '/employeeHome');
      } else if (role == "company") {
        Navigator.pushReplacementNamed(context, '/startupHome');
      } else {
        Navigator.pushReplacementNamed(context, '/employeeHome');
      }

      // Navigator.pushReplacementNamed(context, '/startupHome');
    } else {
      MotionToast.error(
        description: const Text('Either email or password is incorrect'),
      ).show(context);
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController(text: "ram@1234");
  TextEditingController password = TextEditingController(text: "12345678");
  String role = 'Select Role';

  String _luxString = 'Unknown';
  late Light _light;
  late StreamSubscription _subscription;

  void onData(int luxValue) async {
    setState(() {
      _luxString = "$luxValue";
      if (int.parse(_luxString) < 12) {
        Fluttertoast.showToast(
            msg: "Please decrease the brightness of your light",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 157, 57, 223),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException {}
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Image.asset('assets/images/hirexlogo.png'),
                  height: height * 0.1,
                  width: width * 0.3,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: imageSliders,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: SizedBox(
                                height: height * 0.07,
                                child: TextFormField(
                                  controller: email,
                                  decoration: const InputDecoration(
                                    labelText: 'email',
                                    hintText: 'Enter your email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: SizedBox(
                                height: height * 0.07,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      gapPadding: 10.0,
                                    ),
                                  ),
                                  controller: password,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                                child: DropdownButton<String>(
                              value: role,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  role = newValue!;
                                });
                              },
                              items: <String>[
                                'Select Role',
                                'company',
                                'investor',
                                'employee'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 150.0,
                              ),
                              child: Center(
                                  child: InkWell(
                                onTap: () {},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 205, 111, 208),
                                      fontSize: 16),
                                ),
                              )),
                            ),
                            const SizedBox(height: 5),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: SizedBox(
                                width: width * 0.7,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await _login();
                                      Authcontroller().setRole(role);
                                      Authcontroller().setEmail(email.text);
                                      Authcontroller()
                                          .setPassword(password.text);
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/signup',
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                ],
              )),
        ))
    .toList();
