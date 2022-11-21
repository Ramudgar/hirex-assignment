import 'package:flutter/material.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/screenUI/theme/colors.dart';

class AppliedJobsDetails extends StatefulWidget {
  const AppliedJobsDetails({Key? key}) : super(key: key);

  static Route<T> getJobDetail<T>() {
    return MaterialPageRoute(
      builder: (_) => const AppliedJobsDetails(),
    );
  }

  @override
  _AppliedJobsDetailsState createState() => _AppliedJobsDetailsState();
}

class _AppliedJobsDetailsState extends State<AppliedJobsDetails> {
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
          const SizedBox(width: 12),
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                // backgroundColor: ,
                  padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Text("Status: ${job.status}",
                  style: const TextStyle(fontSize: 14, color: KColors.primary)),
            ),
          ),
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
