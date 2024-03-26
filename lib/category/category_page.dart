import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gitpod/gitlist/git_list.dart';
import 'package:gitpod/gitlist/git_model.dart';
import 'package:gitpod/gitlist/git_tile2.dart';
import 'package:gitpod/home/home_appbar.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  final Widget selectedGitList; // Added parameter
  const CategoryPage(
      {Key? key,
      required this.title,
      required this.selectedGitList}); // Corrected constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PageAppBar2(),
                      SizedBox(height: 20),
                      PageAppBar(title: title),
                    ],
                  ),
                ),

                selectedGitList, // Using the selectedGitList parameter
              ],
            ),
          ),
        ),
      ),
    );
  }
}
