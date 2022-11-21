import 'package:flutter/material.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/repository/job_repository.dart';
import 'package:hirexapp/screenUI/theme/colors.dart';
import 'package:hirexapp/screenUI/theme/images.dart';
import 'package:motion_toast/motion_toast.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({Key? key}) : super(key: key);

  static Route<T> getJobDetail<T>() {
    return MaterialPageRoute(
      builder: (_) => const JobDetailPage(),
    );
  }

  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  _deleteJob(Job job) async {
    bool isUpdated = await JobRepository().deleteJob(job);
    if (isUpdated) {
      _displayMessage(isUpdated);
    } else {
      _displayMessage(isUpdated);
    }
  }

  // Display message
  _displayMessage(bool isUpdated) {
    if (isUpdated) {
      MotionToast.success(description: const Text("Job deleted successfully"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Error delteing job"))
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
              CircleAvatar(
                child: Image.network(
                    job.image!.replaceAll('localhost', '10.0.2.2'),
                    height: 60,
                    fit: BoxFit.cover),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: KColors.title,
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
              _headerStatic("Deadline", " ${job.deadline}"),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(
            color: KColors.icon,
            height: 25,
          )
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

  Widget _ourPeople(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.only(left: 16),
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Our People",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _people(context, img: Images.user1, name: "J. Smith"),
                _people(context, img: Images.user2, name: "L. James"),
                _people(context, img: Images.user3, name: "Emma"),
                _people(context, img: Images.user4, name: "Mattews"),
                _people(context, img: Images.user5, name: "Timothy"),
                _people(context, img: Images.user6, name: "Kyole"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _people(BuildContext context, {String? img, String? name}) {
    return Container(
      margin: const EdgeInsets.only(right: 18),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(img!),
          ),
          const SizedBox(height: 8),
          Text(name!,
              style: const TextStyle(fontSize: 10, color: KColors.subtitle)),
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
                Navigator.pushNamed(context, '/jobUpdate', arguments: job);
              },
              child: const Text(
                "Update Now",
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
                onPressed: () {
                  _deleteJob(job);
                },
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
          _ourPeople(context),
          _update(context)
        ],
      ),
    );
  }
}
