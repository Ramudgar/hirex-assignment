import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hirexapp/controller/auth_controller.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/repository/job_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shake/shake.dart';

class AddJob extends StatefulWidget {
  const AddJob({Key? key}) : super(key: key);

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  // Load camera and gallery images and store it to the File object.
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

  // Add product
  _addJob(Job job) async {
    bool isAdded = await JobRepository().addJob(img, job);
    if (isAdded) {
      _displayMessage(isAdded);
    } else {
      _displayMessage(isAdded);
    }
  }

  // Display message
  _displayMessage(bool isAdded) {
    if (isAdded) {
      MotionToast.success(description: const Text("Job added successfully"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Error adding Job"))
          .show(context);
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController jobTitleController =
      TextEditingController(text: "Flutter");
  TextEditingController jobDescriptionController =
      TextEditingController(text: "Job for Flutter Developer");
  TextEditingController jobApplicants = TextEditingController(text: "5");
  TextEditingController jobLocation = TextEditingController(text: "ktm");
  TextEditingController maxPositions = TextEditingController(text: "3");
  TextEditingController jobSalary = TextEditingController(text: "50000");
  TextEditingController dobPosting = TextEditingController(text: "2021-01-01");
  TextEditingController deadline = TextEditingController(text: "2021-01-05");
  TextEditingController jobduration = TextEditingController(text: "3 months");
  TextEditingController skills = TextEditingController(text: "Flutter,Dart");
  String jobType = 'PartTime';

  @override
  void initState() {
    super.initState();
    _checkNotificationEnabled();

    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        Authcontroller.removeAuthToken();
        Navigator.pushNamed(context, '/login');
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  int counter = 1;
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Job',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: jobTitleController,
                  decoration: InputDecoration(
                    labelText: 'Job Title',
                    hintText: 'Enter Job Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: jobDescriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter Description here....',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: jobApplicants,
                  decoration: InputDecoration(
                    labelText: 'max Applicants',
                    hintText: 'Enter total applicants',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: maxPositions,
                  decoration: InputDecoration(
                    labelText: 'total positions',
                    hintText: 'Enter total positions',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: jobSalary,
                  decoration: InputDecoration(
                    labelText: 'Salary',
                    hintText: 'Enter Salary',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: dobPosting,
                  decoration: InputDecoration(
                    labelText: 'date of job posting',
                    hintText: 'Enter date of posting',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: deadline,
                  decoration: InputDecoration(
                    labelText: 'deadline',
                    hintText: 'Enter deadline',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: jobduration,
                  decoration: InputDecoration(
                    labelText: 'duration',
                    hintText: 'Enter duration',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: skills,
                  decoration: InputDecoration(
                    labelText: 'Skills',
                    hintText: 'Enter skills',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: jobLocation,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'Enter Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                    child: DropdownButton<String>(
                  value: jobType,
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
                      jobType = newValue!;
                    });
                  },
                  items: <String>[
                    'Select Job type',
                    'Contract',
                    'FullTime',
                    'PartTime',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  margin: const EdgeInsets.only(bottom: 40),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Job job = Job(
                            title: jobTitleController.text,
                            description: jobDescriptionController.text,
                            maxApplicants: int.parse(jobApplicants.text),
                            maxPositions: int.parse(maxPositions.text),
                            salary: jobSalary.text,
                            dateOfPosting: dobPosting.text,
                            deadline: deadline.text,
                            duration: jobduration.text,
                            skills: skills.text,
                            location: jobLocation.text,
                            jobType: jobType,
                          );
                          _addJob(job);

                          AwesomeNotifications().createNotification(
                              content: NotificationContent(
                                  id: counter,
                                  channelKey: 'basic_channel',
                                  title: 'Notification title',
                                  body:
                                      "Job is successfully added to the system please visit"));
                          setState(() {
                            counter++;
                          });
                        }
                      },
                      child: const Text('Add Job')),
                ),
              ],
            ),
          ),
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
