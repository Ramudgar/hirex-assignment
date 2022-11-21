import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hirexapp/model/user.dart';
import 'package:hirexapp/repository/user_repository.dart';
import 'package:hirexapp/screenUI/Login%20and%20signup/login.dart';
import 'package:hirexapp/utils/showMessage.dart';
import 'package:image_picker/image_picker.dart';

class SignUstartup extends StatefulWidget {
  const SignUstartup({Key? key}) : super(key: key);

  @override
  State<SignUstartup> createState() => _SignUstartupState();
}

class _SignUstartupState extends State<SignUstartup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final role = "company";

  _companyRegister(User user) async {
    bool isLogin = await UserRepository().registerUser(user);
    debugPrint((isLogin).toString());
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

  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Company Signup Page'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 26, 62),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 8, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.amber,
                        actions: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _loadImage(ImageSource.camera);
                              },
                              child: const Text('Open Camera'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _loadImage(ImageSource.gallery);
                              },
                              child: const Text('Open Gallery'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, 'Cancel');
                              },
                              child: const Text('Cancell'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    child: SizedBox(
                      child: _displayImage(),
                      height: height * 0.3,
                      width: width * 0.9,
                    ),
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
                                  hintText: 'Enter your  username',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Company username';
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
                                  hintText: 'Enter company emial',
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter company email';
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
                                    setState(() {
                                      Navigator.pushNamed(context, '/login');
                                    });
                                    _companyRegister(user);
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
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
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

  Widget _displayImage() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Color.fromARGB(255, 185, 104, 69),
          width: 3,
        ),
      ),
      child: ClipRRect(
        // For rounded upper right corner and left corner in imageview
        borderRadius: BorderRadius.circular(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              img == null
                  ? Image.network(
                      'https://images.livemint.com/img/2021/05/25/1600x900/startup-kElG--621x414@LiveMint_1621958814569.jpg',
                      fit: BoxFit.cover,
                      height: height * 0.26,
                      width: width * 0.9,
                    )
                  : Image.file(img!),
            ],
          ),
        ),
      ),
    );
  }
}
