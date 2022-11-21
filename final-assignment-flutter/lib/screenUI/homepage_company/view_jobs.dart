import 'package:flutter/material.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/repository/job_repository.dart';
import 'package:hirexapp/response/get_job_response.dart';
import 'package:hirexapp/screenUI/theme/colors.dart';
import 'package:hirexapp/utils/url.dart';

class MyJobs extends StatefulWidget {
  const MyJobs({Key? key}) : super(key: key);

  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  String imageUrl =
      "https://assets-api.kathmandupost.com/thumb.php?src=https://assets-cdn.kathmandupost.com/uploads/source/news/2022/opinion/shutterstock1358850531-1642092669.jpg&w=900&height=601";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 55, 163, 246),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.shopping_cart),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: FutureBuilder<JobResponse?>(
                future: JobRepository().getJob(),
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
                                    '/jobDetailPage',
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
                                        "${lstJob[index].title!} \t (${lstJob[index].jobType!})"),
                                    subtitle: Text(
                                      "deadline: ${lstJob[index].deadline!}\t"
                                      "location: ${lstJob[index].location}",
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
