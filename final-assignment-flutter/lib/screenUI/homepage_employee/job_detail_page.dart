import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/repository/job_repository.dart';
import 'package:hirexapp/screenUI/theme/colors.dart';
import 'package:motion_toast/motion_toast.dart';

class JobDetailPageEmployee extends StatefulWidget {
  const JobDetailPageEmployee({Key? key}) : super(key: key);

  static Route<T> getJobDetail<T>() {
    return MaterialPageRoute(
      builder: (_) => const JobDetailPageEmployee(),
    );
  }

  @override
  _JobDetailPageEmployeeState createState() => _JobDetailPageEmployeeState();
}

class _JobDetailPageEmployeeState extends State<JobDetailPageEmployee> {
  int counter = 1;
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();

    super.initState();
  }

// / Add product
  _applyUpdate(Job job) async {
    bool isUpdated = await JobRepository().applyUpdate(job);
    if (isUpdated) {
      _displayMessage(isUpdated);
    } else {
      _displayMessage(isUpdated);
    }
  }

  // Display message
  _displayMessage(bool isUpdated) {
    if (isUpdated) {
      MotionToast.success(description: const Text("Job applied successfully"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Error applying Job"))
          .show(context);
    }
  }

  Widget _header(BuildContext context) {
    Job job = ModalRoute.of(context)!.settings.arguments as Job;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: job.image != null
                      ? NetworkImage(
                          job.image!.replaceAll('localhost', '10.0.2.2'),
                        )
                      : Image.asset('assets/images/avtar.jpg').image,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      job.title!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: KColors.title,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Required Skills: ${job.skills}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: KColors.subtitle,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _headerStatic("Salary", "Rs ${job.salary}"),
              _headerStatic("candidates", "${job.maxPositions}"),
              _headerStatic("Applicants", " ${job.maxApplicants}"),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(
            color: KColors.icon,
            height: 25,
          ),
          const SizedBox()
        ],
      ),
    );
  }

  Widget _headerStatic(String title, String sub) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 107, 137, 148),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            sub,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 39, 129),
            ),
          )
        ],
      ),
    );
  }

  Widget _jobDescription(BuildContext context) {
    Job job = ModalRoute.of(context)!.settings.arguments as Job;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              "Job Posted on: ${job.dateOfPosting} \t deadline: ${job.deadline} \n\n Availiable Positions:${job.maxPositions}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: KColors.title,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Job Description",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            job.description!,
            style: const TextStyle(fontSize: 14, color: KColors.subtitle),
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            child: const Text("Learn more",
                style: TextStyle(fontSize: 14, color: KColors.primary)),
          )
        ],
      ),
    );
  }

  Widget _update(BuildContext context) {
    Job job = ModalRoute.of(context)!.settings.arguments as Job;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 70),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(KColors.primary),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16))),
              onPressed: () {
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                        id: counter,
                        channelKey: 'basic_channel',
                        title: 'Notification title',
                        body: "Job is applied successfully"));
                setState(() {
                  counter++;
                });
                _applyUpdate(job);
              },
              child: const Text(
                "Apply Now",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 50,
            width: 60,
            child: Container(
              color: const Color.fromARGB(255, 139, 16, 8),
              child: OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(color: KColors.primary),
                  ),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Color.fromARGB(255, 245, 240, 240),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.background,
        iconTheme: const IconThemeData(color: KColors.primary),
        elevation: 1,
        actions: [
          IconButton(
              icon: const Icon(Icons.cloud_upload_outlined), onPressed: () {})
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          _jobDescription(context),
          _update(context)
        ],
      ),
    );
  }
}
