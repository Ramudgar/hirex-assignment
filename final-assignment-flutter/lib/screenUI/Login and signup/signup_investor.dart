import 'package:flutter/material.dart';
import 'package:hirexapp/model/user.dart';
import 'package:hirexapp/repository/user_repository.dart';
import 'package:hirexapp/utils/showMessage.dart';

class SignUpInvestor extends StatefulWidget {
  const SignUpInvestor({Key? key}) : super(key: key);

  @override
  State<SignUpInvestor> createState() => _SignUpInvestorState();
}

class _SignUpInvestorState extends State<SignUpInvestor> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final role = "investor";

  _investorRegister(User user) async {
    bool isLogin = await UserRepository().registerUser(user);
    if (isLogin) {
      _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(bool isLogin) {
    if (isLogin) {
      displaySuccessMessage(context, 'Successfully registered');
    } else {
      displayErrorMessage(context, 'Error registering');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investor Signup Page'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 26, 62),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 8, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 19, 59, 238),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 92, 235, 223)
                          .withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset: const Offset(3, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://149695847.v2.pressablecdn.com/wp-content/uploads/2019/07/investor-banner-01.jpg',
                    fit: BoxFit.cover,
                    height: height * 0.3,
                    width: width * 0.9,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const SizedBox(
              child: Text(
                'SignUp Form',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flexible(
                fit: FlexFit.loose,
                child: Container(
                  height: height * 0.51,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 16, 26, 62),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 131, 197, 232)
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: TextFormField(
                                controller: _username,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter your username',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Your username';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: TextFormField(
                                controller: _email,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter your emial',
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: TextFormField(
                                controller: _password,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter password!',
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    User user = User(
                                      username: _username.text,
                                      email: _email.text,
                                      password: _password.text,
                                      role: role,
                                    );
                                    _investorRegister(user);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 235, 197, 84),
                                  padding: const EdgeInsets.all(10),
                                ),
                                child: const Text(
                                  'SignUp',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              child: InkWell(
                                child: const Text(
                                  'Already have an account? SignIn',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
