import 'package:flutter/material.dart';
import 'package:hirexapp/screenUI/wearOSApp%20and%20Notifications/LoginWearOs.dart';
import 'package:wear/wear.dart';

class WearosLoginPage extends StatefulWidget {
  const WearosLoginPage({Key? key}) : super(key: key);

  @override
  State<WearosLoginPage> createState() => _WearosLoginPageState();
}

class _WearosLoginPageState extends State<WearosLoginPage> {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Welcome to HireX',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WearOSScreen(),
                    ),
                  );
                },
                child: const Text('Proceed to login'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
