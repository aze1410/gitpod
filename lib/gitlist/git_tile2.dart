import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gitpod/gitlist/git_model.dart';
import 'package:gitpod/gitlist/git_page.dart';

class GitTile2 extends StatelessWidget {
  final GitModel gitModel;
  const GitTile2({Key? key, required this.gitModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GitPage(gitModel: gitModel),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 190,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gitModel.name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Today , Shared by " + gitModel.name,
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Team",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          ClipOval(
                            child: Image.network(
                              gitModel.ownerAvatarUrl,
                              scale: 15,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width:
                                      30, // Set width as per your requirement
                                  height:
                                      30, // Set height as per your requirement
                                  color: Colors
                                      .grey, // Set a placeholder color or any other widget to show when there's an error
                                  // You can also add any child widgets or error message here
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //

                gitModel.isOpenIssuesCount == 0
                    ? LinearCircleIndicator(
                        percent: 100,
                        indicatorColor: Colors.green.shade200,
                        indicatorWidth: 200,
                      )
                    : LinearCircleIndicator(
                        percent: 65,
                        indicatorColor: Color.fromARGB(255, 142, 125, 255),
                        indicatorWidth: 120,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinearCircleIndicator extends StatelessWidget {
  final int percent;
  final double indicatorWidth;
  final Color indicatorColor;

  const LinearCircleIndicator({
    Key? key,
    required this.indicatorWidth,
    required this.indicatorColor,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 50,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: Center(
                  child: Text(
                    "$percent%",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: SizedBox(
                height: 90,
                width: 90,
                child: CircularProgressIndicator(
                  strokeWidth: 8, // Adjust the thickness as needed
                  value: percent / 100, // Set the progress value
                  valueColor: AlwaysStoppedAnimation<Color>(
                    indicatorColor, // Use the provided indicator color
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
