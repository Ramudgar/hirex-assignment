// ignore: file_names
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hirexapp/repository/user_repository.dart';
import 'package:wear/wear.dart';

class WearOSScreen extends StatefulWidget {
  const WearOSScreen({Key? key}) : super(key: key);

  @override
  State<WearOSScreen> createState() => _WearOSScreenState();
}

class _WearOSScreenState extends State<WearOSScreen> {
  int counter = 1;
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();

    super.initState();
  }

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
      Fluttertoast.showToast(
        msg: 'sum is',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.transparent,
        textColor: Colors.black,
      );

      // MotionToast.error(
      //   description: Text("Error:${e.toString()}"),
      // ).show(context);
    }
  }

  navigateToScreen(bool isLogin) async {
    if (isLogin) {
      if (role == "employee") {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (role == "company") {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
      Fluttertoast.showToast(
          msg: 'user logged in successfully ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);

      // Navigator.pushReplacementNamed(context, '/startupHome');
    } else {
      Fluttertoast.showToast(
        msg: 'Error in user logging ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      // MotionToast.error(
      //   description: const Text('Either email or password is incorrect'),
      // ).show(context);
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController(text: "ram@1234");
  TextEditingController password = TextEditingController(text: "12345678");
  String role = 'Select Role';

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(builder: (context, mode, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: 'Enter email',
                        hintText: 'enter an email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Enter password',
                        hintText: 'enter a valid password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 2),
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
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                          AwesomeNotifications().createNotification(
                              content: NotificationContent(
                                  id: counter,
                                  channelKey: 'basic_channel',
                                  title: 'Notification title',
                                  body:
                                      "User logged in successfully with email: ${email.text} "));
                          setState(() {
                            counter++;
                          });
                        },
                        child: const Text('Login'),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
