// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: -40,
                      height: 400,
                      width: width,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: const DecorationImage(
                                opacity: 0.8,
                                image: const AssetImage(
                                    'assets/images/investor.jpg'),
                                fit: BoxFit.fill)),
                      )),
                  Positioned(
                      height: 400,
                      width: width + 20,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: const DecorationImage(
                                image:
                                    const AssetImage('assets/images/hirex.png'),
                                fit: BoxFit.fill)),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Login",
                    style: const TextStyle(
                        color: const Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                hintText: 'Username/Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(49, 39, 79, 1),
                                    fontSize: 15),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter username/email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: InkWell(
                    onTap: () {},
                    child: const Text(
                      "Forgot Password?",
                      style:
                          TextStyle(color: Color.fromARGB(255, 205, 111, 208)),
                    ),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 60),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black, // Background color
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
