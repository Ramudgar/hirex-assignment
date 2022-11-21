import 'package:flutter/material.dart';
import 'package:hirexapp/controller/auth_controller.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/repository/job_repository.dart';
import 'package:hirexapp/response/get_job_response.dart';
import 'package:hirexapp/screenUI/theme/colors.dart';
import 'package:hirexapp/utils/url.dart';
import 'package:shake/shake.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl =
      "https://assets-api.kathmandupost.com/thumb.php?src=https://assets-cdn.kathmandupost.com/uploads/source/news/2022/opinion/shutterstock1358850531-1642092669.jpg&w=900&height=601";
//  Shake detector
  @override
  void initState() {
    super.initState();
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

    // detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('All Jobs'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 55, 163, 246),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: FutureBuilder<JobResponse?>(
                future: JobRepository().getAllJob(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      // ProductResponse productResponse = snapshot.data!;
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
                                    '/jobDetailPageEmployee',
                                    arguments: lstJob[index],
                                  );
                                },
                                child: Card(
                                  elevation: 5,
                                  color:
                                      const Color.fromARGB(255, 181, 217, 234),
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
                                        "${lstJob[index].title!}\t (${lstJob[index].jobType!})"),
                                    isThreeLine: true,
                                    subtitle: Text(
                                      "deadline: ${lstJob[index].deadline!} \t"
                                      "location: ${lstJob[index].location!}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 17, 29, 35),
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
                        child: Text('No data'),
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Text('Error retrieving data');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayProducts(Job job) {
    return Card(
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              job.image!,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _header(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Hello Jason",
            style: TextStyle(
              fontSize: 15,
              color: KColors.subtitle,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(
          height: 6,
        ),
        const Text("Find your perfect job",
            style: TextStyle(
                fontSize: 20,
                color: KColors.title,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                    color: KColors.lightGrey,
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "What are you looking for?",
                  style: TextStyle(fontSize: 15, color: KColors.subtitle),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: KColors.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 40,
              child: IconButton(
                color: KColors.primary,
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            )
          ],
        )
      ],
    ),
  );
}
