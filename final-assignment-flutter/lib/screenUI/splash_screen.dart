import 'package:flutter/material.dart';
import 'package:hirexapp/controller/auth_controller.dart';
import 'package:hirexapp/screenUI/Login%20and%20signup/login.dart';
import 'package:hirexapp/screenUI/homepage_company/bottom_page.dart';
import 'package:hirexapp/screenUI/homepage_employee/homes_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // this is function which checks if the user is logged in or not and if the user is logged in then it will redirect to the homepage of the user

  Widget? myWidget;

  @override
  void initState() {
    checkSharedPref();
    super.initState();
  }

  // function to check wheter the user is logged in or not by checking user email and password stored in the shared prefences
  // void checkSharedPref() async {
  //   String? email = await Authcontroller.getEmail();
  //   String? password = await Authcontroller.getPassword();
  //   String? role = await Authcontroller.getRole();
  //   if (email != null && password != null && role != null) {
  //     if (role == "employee") {
  //       myWidget = const BottomNavigation();
  //     } else {
  //       myWidget = const HomePage();
  //     }
  //   } else {
  //     myWidget = const LoginPage();
  //   }
  // }

  checkSharedPref() async {
    Future.delayed(const Duration(seconds: 3), () async {
      final token = await Authcontroller.getAuthToken();
      final role = await Authcontroller.getRole();
      final email = await Authcontroller.getEmail();
      final password = await Authcontroller.getPassword();
        // Navigator.pushReplacementNamed(context, '/login');

      if (token != null &&
          token.isNotEmpty &&
          email != null &&
          password != null) {
        if (role == 'company') {
          setState(() {
            myWidget = const BottomNavigation();
          });
        } else if (role == 'investor') {
          setState(() {
            myWidget = const HomePage();
          });
        } else {
          setState(() {
            myWidget = const BottomNavigation();
          });
        }
      }

      // setState(() {
      //   myWidget = const BottomNavigation();
      // });
      else {
        // Navigator.pushReplacementNamed(context, '/login');
        setState(() {
          myWidget = const LoginPage();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      duration: 3500,
      imageSize: 250,
      imageSrc: 'assets/images/hireslogo.jpg',
      text: "HireX App",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 35.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
      navigateRoute: myWidget,
    );
  }
}
