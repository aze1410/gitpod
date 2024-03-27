import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gitpod/gitlist/git_model.dart';
import 'package:gitpod/gitlist/git_tile2.dart';
import 'package:gitpod/home/home_appbar.dart';

class GitPage extends StatelessWidget {
  final GitModel gitModel;
  const GitPage({super.key, required this.gitModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageAppBar2(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gitModel.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Today , Shared by " + gitModel.name,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star_sharp, color: Colors.yellow.shade800),
                        Text(gitModel.stars.toString()),
                        SizedBox(width: 8),
                        Text("Stars"),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      gitModel.isOpenIssuesCount == 0
                          ? LinearCircleIndicator(
                              percent: 100,
                              indicatorColor: Colors.green.shade200,
                              indicatorWidth: 200,
                            )
                          : LinearCircleIndicator(
                              percent: 65,
                              indicatorColor:
                                  Color.fromARGB(255, 142, 125, 255),
                              indicatorWidth: 120,
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Team",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          ClipOval(
                              child: Image.network(
                            gitModel.ownerAvatarUrl,
                            scale: 15,
                          )),
                          SizedBox(height: 15),
                          Text(
                            "Deadline",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Icon(
                                  Icons.calendar_month_rounded,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                              Text(
                                "July 25, 2024 - July 30, 2024",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                //
                SizedBox(height: 10),

                Text(
                  "Project Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    gitModel.description,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Project Progress",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: gitModel.topics
                        .map(
                          (topic) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, right: 8.0),
                                child: Icon(Icons.check_circle,
                                    size: 16, color: Colors.green),
                              ),
                              Expanded(
                                child: Text(
                                  topic,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
