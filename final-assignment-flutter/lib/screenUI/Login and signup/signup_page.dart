import 'package:flutter/material.dart';

class Signup_page extends StatefulWidget {
  const Signup_page({Key? key}) : super(key: key);

  @override
  State<Signup_page> createState() => _Signup_pageState();
}

class _Signup_pageState extends State<Signup_page> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  child: Image.asset('assets/images/hirexlogo.png'),
                  height: height * 0.07,
                  width: width * 0.7,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 19, 59, 238),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 131, 197, 232)
                          .withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://cdn.techinasia.com/wp-content/uploads/2016/02/Startup-Office.jpg',
                      fit: BoxFit.cover,
                      height: height * 0.3,
                      width: width * 0.9,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              child: Text(
                'Sign Up As',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signupStartup');
                      },
                      child: const Text(
                        'Startup company',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 53, 104, 222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signupEmployee');
                      },
                      child: const Text('Employee',
                          style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 53, 104, 222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signupInvestor');
                      },
                      child: const Text('Investor',
                          style: TextStyle(fontSize: 17)),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 53, 104, 222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(
                  color: Color.fromARGB(255, 41, 55, 68),
                  fontSize: 15,
                  shadows: [
                    Shadow(
                      blurRadius: 1,
                      color: Color.fromARGB(255, 27, 28, 30),
                      offset: Offset(0, 0.6),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
