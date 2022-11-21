import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/repository/job_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class EditJob extends StatefulWidget {
  const EditJob({Key? key}) : super(key: key);

  @override
  State<EditJob> createState() => _EditJobState();
}

class _EditJobState extends State<EditJob> {
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
  _editJob(Job job) async {
    bool isUpdated = await JobRepository().updateJob(img, job);
    if (isUpdated) {
      _displayMessage(isUpdated);
    } else {
      _displayMessage(isUpdated);
    }
  }

  // Display message
  _displayMessage(bool isUpdated) {
    if (isUpdated) {
      MotionToast.success(description: const Text("Job updated successfully"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Error updating Job"))
          .show(context);
    }
  }

  final _formKey = GlobalKey<FormState>();
  // String title = "";
  // String description = "";
  // String location = "";
  // String salary = "";
  // String maxApplicants = '';
  // String maxPositions = '';
  // String duration = "";
  // String dateOfPosting = "";
  // String deadline = "";
  // String skills = "";

  String jobType = 'PartTime';

  @override
  Widget build(BuildContext context) {
    Job job = ModalRoute.of(context)!.settings.arguments as Job;
    // String id = job.id!;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Job',
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
                  decoration: InputDecoration(
                    labelText: 'Job Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: job.title,
                  onChanged: (value) => job.title = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter job title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: job.description,
                  onChanged: (value) => job.description = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter job description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'max Applicants',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: job.maxApplicants.toString(),
                  onChanged: (value) => job.maxApplicants = int.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter total applicants';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'total positions',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: job.maxPositions.toString(),
                  onChanged: (value) => job.maxPositions = int.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter total applicants';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Salary',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    initialValue: job.salary,
                    onChanged: (value) => job.salary = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter salary';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'date of job posting',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: job.dateOfPosting,
                  onChanged: (value) => job.dateOfPosting = value,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'deadline',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: job.deadline,
                  onChanged: (value) => job.deadline = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter deadline';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'duration',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: job.duration,
                  onChanged: (value) => job.duration = value,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Skills',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: job.skills,
                  onChanged: (value) => job.skills = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter skills';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialValue: job.location,
                  onChanged: (value) => job.location = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
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
                          _editJob(job);
                        }
                      },
                      child: const Text('Update Job')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayImage() {
    Job job = ModalRoute.of(context)!.settings.arguments as Job;

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
                      job.image!.replaceAll('localhost', '10.0.2.2'),
                      fit: BoxFit.cover,
                      height: height * 0.3,
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
