import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:hirexapp/controller/auth_controller.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/repository/job_repository.dart';
import 'package:hirexapp/response/get_job_response.dart';
import 'package:hirexapp/screenUI/Login%20and%20signup/login.dart';
import 'package:hirexapp/utils/url.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpSetting extends StatefulWidget {
  const EmpSetting({Key? key}) : super(key: key);

  @override
  State<EmpSetting> createState() => _EmpSettingState();
}

class _EmpSettingState extends State<EmpSetting> {
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
        if (_isNear == true) {
          Navigator.pushNamed(context, '/empProfile');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // functions for logout and remove the token from the shared preferences
    Future<void> logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool('isLoggedIn', false);
      prefs.remove(AuthStatus.authToken
          .toString()); //Auth status.authToken is the key of the token in the shared preferences and is imported from the Authcontroller class
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
        centerTitle: true,
      ),
      drawer: SafeArea(
        child: Drawer(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 41, 130, 238),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/passwordChange');
                    },
                    leading: const Icon(
                      Icons.password_outlined,
                      color: Colors.white,
                    ),
                    title: const Text('Chanege Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/google_maps');
                    },
                    leading: const Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                    title: const Text('View Location',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/lightsensor');
                    },
                    leading: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    title: const Text('Delete Account',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    onTap: () {
                      logout();
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: const Text('Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FutureBuilder<JobResponse?>(
                  future: JobRepository().getAppliedJob(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<Job> lstJob = snapshot.data!.jobs!;

                        return ListView.builder(
                          itemCount: snapshot.data!.jobs!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/appliedJobsDetails',
                                      arguments: lstJob[index],
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: const Color.fromARGB(
                                        255, 181, 217, 234),
                                    child: ListTile(
                                      leading: baseUrl.contains('10.0.2.2')
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                lstJob[index].image!.replaceAll(
                                                    'localhost', '10.0.2.2'),
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  lstJob[index].image!),
                                            ),
                                      title: Text(
                                          " ${lstJob[index].title!} \t (${lstJob[index].jobType!}) \t Skills: ${lstJob[index].skills!} ",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                        "Status:${lstJob[index].status!} \t \t"
                                        "deadline: ${lstJob[index].deadline!} ",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 17, 29, 35),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No Applications'),
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(
                        child: Text("data is not found in snapshot"),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
