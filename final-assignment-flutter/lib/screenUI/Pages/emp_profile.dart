import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hirexapp/model/profile.dart';
import 'package:hirexapp/repository/profile_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class EmpProfilePage extends StatefulWidget {
  const EmpProfilePage({Key? key}) : super(key: key);

  @override
  State<EmpProfilePage> createState() => _EmpProfilePageState();
}

class _EmpProfilePageState extends State<EmpProfilePage> {
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

  // Add profile function
  _addProfile(Profile profile) async {
    bool isAdded = await ProfileRepository().addProfile(img, profile);
    if (isAdded) {
      _displayMessage(isAdded);
    } else {
      _displayMessage(isAdded);
    }
  }

  // update profile function
  _updateProfile(Profile profile) async {
    bool isUpdated = await ProfileRepository().updateProfile(img, profile);
    if (isUpdated) {
      _displayUpdatedMessage(isUpdated);
    } else {
      _displayUpdatedMessage(isUpdated);
    }
  }

  // Display message
  _displayMessage(bool isAdded) {
    if (isAdded) {
      MotionToast.success(description: const Text("profile added successfully"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Error adding profile"))
          .show(context);
    }
  }

  _displayUpdatedMessage(bool isUpdated) {
    if (isUpdated) {
      MotionToast.success(
              description: const Text("profile updated successfully"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Error updating profile"))
          .show(context);
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController =
      TextEditingController(text: "Ram Udgar Yadav");
  TextEditingController phoneController =
      TextEditingController(text: "+977 9811722711");
  TextEditingController skillsController =
      TextEditingController(text: "Flutter, Dart");
  TextEditingController countryController =
      TextEditingController(text: "Nepal");
  TextEditingController cityController =
      TextEditingController(text: "Kathmandu");
  TextEditingController stateController =
      TextEditingController(text: "Kathmandu");
  TextEditingController experienceController =
      TextEditingController(text: "2 years");
  TextEditingController institutionNameController =
      TextEditingController(text: "Coventry University");
  TextEditingController degreeController =
      TextEditingController(text: "Bachelor of Science");
  TextEditingController startYearController =
      TextEditingController(text: "2020");
  TextEditingController endYearController = TextEditingController(text: "2023");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 193, 222, 245),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: img != null
                                ? Image.file(img!).image
                                : Image.asset('assets/images/startup.jpg')
                                    .image,
                            backgroundColor:
                                const Color.fromARGB(179, 209, 189, 189),
                            radius: 70,
                            child: InkWell(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Select Image",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue)),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        GestureDetector(
                                          child: const Text("Take Photo",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue)),
                                          onTap: () =>
                                              _loadImage(ImageSource.camera),
                                        ),
                                        const SizedBox(height: 10),
                                        GestureDetector(
                                          child: const Text("Open Gallery",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue)),
                                          onTap: () =>
                                              _loadImage(ImageSource.gallery),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // child: ClipOval(
                              //   child: (img != null)
                              //       ? Image.file(img!)
                              //       : Image.asset('assets/images/startup.jpg'),
                              // ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Ramudgar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Full  Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: experienceController,
                          decoration: const InputDecoration(
                            labelText: 'Experience',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: skillsController,
                          decoration: const InputDecoration(
                            labelText: 'Skills',
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          const Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: countryController,
                              decoration: const InputDecoration(
                                labelText: 'Country',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: cityController,
                              decoration: const InputDecoration(
                                labelText: 'City',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: stateController,
                              decoration: const InputDecoration(
                                labelText: 'State',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Education',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: institutionNameController,
                              decoration: const InputDecoration(
                                labelText: 'Institution Name',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: degreeController,
                              decoration: const InputDecoration(
                                labelText: 'Degree ',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: startYearController,
                              decoration: const InputDecoration(
                                labelText: 'Start-Year',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: endYearController,
                              decoration: const InputDecoration(
                                labelText: 'End-Year',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: addButton(),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: updateButton(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//  creat elevated button and store it on new widget class
  Widget addButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Profile profile = Profile(
            name: nameController.text,
            phone: phoneController.text,
            experience: experienceController.text,
            skills: skillsController.text,
            country: countryController.text,
            city: cityController.text,
            state: stateController.text,
            institutionName: institutionNameController.text,
            degree: degreeController.text,
            startYear: startYearController.text,
            endYear: endYearController.text,
          );
          _addProfile(profile);
        }
      },
      child: const Text('Add Profile'),
    );
  }

// create elevated button and store it on new widget class
  Widget updateButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Profile profile = Profile(
            name: nameController.text,
            phone: phoneController.text,
            experience: experienceController.text,
            skills: skillsController.text,
            country: countryController.text,
            city: cityController.text,
            state: stateController.text,
            institutionName: institutionNameController.text,
            degree: degreeController.text,
            startYear: startYearController.text,
            endYear: endYearController.text,
          );
          _updateProfile(profile);
        }
      },
      child: const Text('Edit Profile'),
    );
  }
}
