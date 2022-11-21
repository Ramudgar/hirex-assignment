import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hirexapp/screenUI/Login%20and%20signup/login.dart';
import 'package:hirexapp/screenUI/Login%20and%20signup/signup_employee.dart';
import 'package:hirexapp/screenUI/Login%20and%20signup/signup_investor.dart';
import 'package:hirexapp/screenUI/Login%20and%20signup/signup_page.dart';
import 'package:hirexapp/screenUI/Login%20and%20signup/signup_startup.dart';
import 'package:hirexapp/screenUI/Pages/changePassword.dart';
import 'package:hirexapp/screenUI/Pages/emp_profile.dart';
import 'package:hirexapp/screenUI/google_maps/google_maps.dart';
import 'package:hirexapp/screenUI/homepage_company/applicants_detail.dart';
import 'package:hirexapp/screenUI/homepage_company/bottom_page.dart';
import 'package:hirexapp/screenUI/homepage_company/edit_job.dart';
import 'package:hirexapp/screenUI/homepage_company/veiw_detailsJob.dart';
import 'package:hirexapp/screenUI/homepage_company/view_jobs.dart';
import 'package:hirexapp/screenUI/homepage_employee/applied_detailPage.dart';
import 'package:hirexapp/screenUI/homepage_employee/bottom_menu_bar.dart';
import 'package:hirexapp/screenUI/homepage_employee/homes_screen.dart';
import 'package:hirexapp/screenUI/homepage_employee/job_detail_page.dart';
import 'package:hirexapp/screenUI/onboarding.dart';
import 'package:hirexapp/screenUI/sensors/fingerprint.dart';
import 'package:hirexapp/screenUI/splash_screen.dart';
import 'package:hirexapp/screenUI/wearOSApp%20and%20Notifications/notifications.dart';
import 'package:hirexapp/screenUI/wearOSApp%20and%20Notifications/wearosDashboard.dart';

void main() async {
  AwesomeNotifications().initialize('resource://drawable/launcher', [
    NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic notifications",
        channelDescription: "Notification channel for basic",
        defaultColor: Colors.amber,
        importance: NotificationImportance.Max,
        ledColor: Colors.white,
        channelShowBadge: true)
  ]);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      // '/': (context) => const WearosLoginPage(),
      '/': (context) => const SplashScreen(),
      '/login': (context) => const LoginPage(),
      '/onboarding': (context) => const OnboardingScreen(),
      '/signup': (context) => const Signup_page(),
      '/signupStartup': (context) => const SignUstartup(),
      '/signupInvestor': (context) => const SignUpInvestor(),
      '/signupEmployee': (context) => const SignupEmployee(),
      '/employeeHome': (context) => const BottomMenuBar(),
      '/empDetailPage': (context) => const HomePage(),
      '/startupHome': (context) => const BottomNavigation(),
      '/jobDetailPage': (context) => const JobDetailPage(),
      '/jobUpdate': (context) => const EditJob(),
      '/empProfile': (context) => const EmpProfilePage(),
      '/google_maps': (context) => const GoogleMapsScreen(),
      '/notification': (context) => const NotificationScreen(),
      '/jobDetailPageEmployee': (context) => const JobDetailPageEmployee(),
      '/appliedJobsDetails': (context) => const AppliedJobsDetails(),
      '/applicantJobsDetails': (context) => const AppllcantDetails(),
      '/dashboard': (context) => const Dashboard(),
      '/viewJobs': (context) => const MyJobs(),
      '/fingerprint': (context) => const Fingerprint(),
      '/passwordChange': (context) => const PasswordChange(),
    },
  ));
}
