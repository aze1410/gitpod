import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gitpod/gitlist/git_model.dart';
import 'package:gitpod/gitlist/git_page.dart';

class GitTile1 extends StatelessWidget {
  final GitModel gitModel;
  const GitTile1({Key? key, required this.gitModel}) : super(key: key);

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
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // grey tick for incomplete green tick for completed
                Row(
                  children: [
                    gitModel.isOpenIssuesCount == 0
                        ? CompleteTickWidget()
                        : IncompleteTickWidget(),

                    //column for name and progress indicaotr
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gitModel.name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          gitModel.isOpenIssuesCount == 0
                              ? LinearColorIndicatior(
                                  indicatorColor: Colors.green.shade200,
                                  indicatorWidth: 200,
                                )
                              : LinearColorIndicatior(
                                  indicatorColor:
                                      Color.fromARGB(255, 142, 125, 255),
                                  indicatorWidth: 120,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),

                // contributors avators
                Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        gitModel.ownerAvatarUrl,
                        scale: 15,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 30, // Set width as per your requirement
                            height: 30, // Set height as per your requirement
                            color: Colors
                                .grey, // Set a placeholder color or any other widget to show when there's an error
                            // You can also add any child widgets or error message here
                          );
                        },
                      ),
                    ),

                    // next button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinearColorIndicatior extends StatelessWidget {
  final double indicatorWidth;
  final Color indicatorColor;

  const LinearColorIndicatior({
    Key? key,
    required this.indicatorWidth,
    required this.indicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Stack(
        children: [
          Container(
            height: 9,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            height: 9,
            width: indicatorWidth,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}

class IncompleteTickWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.done_rounded,
          color: Colors.grey,
          size: 16,
        ),
      ),
    );
  }
}

class CompleteTickWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.done_rounded,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
