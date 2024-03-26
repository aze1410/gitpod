import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitpod/gitlist/git_list.dart';
import 'package:gitpod/category/category_grid.dart';
import 'package:gitpod/category/category_page.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CategoryBox(
                color: const Color.fromARGB(255, 255, 194, 103),
                iconData: Icons.access_time_sharp,
                title: "InProgess",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        title: 'In Progress',
                        selectedGitList: SelectedGitList(
                            selectedStatus: ProjectStatus.inProgress),
                      ),
                    ),
                  );
                }),
            CategoryBox(
                color: Color.fromARGB(255, 142, 125, 255),
                iconData: Icons.repeat,
                title: "Ongoing",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        title: 'Ongoing',
                        selectedGitList: SelectedGitList(
                            selectedStatus: ProjectStatus.inProgress),
                      ),
                    ),
                  );
                }),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CategoryBox(
                color: Colors.green.shade200,
                iconData: Icons.file_download_done_rounded,
                title: "Completed",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        title: 'Completed',
                        selectedGitList: SelectedGitList(
                            selectedStatus: ProjectStatus.completed),
                      ),
                    ),
                  );
                }),
            CategoryBox(
                color: Color.fromARGB(255, 248, 119, 27),
                iconData: Icons.cancel_outlined,
                title: "Cancel",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        title: 'Cancel',
                        selectedGitList: SelectedGitList(
                            selectedStatus: ProjectStatus.canceled),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ],
    );
  }
}



class CategoryBox extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final String title;
  final VoidCallback onTap; // Callback function for onTap event

  const CategoryBox({
    Key? key,
    required this.color,
    required this.iconData,
    required this.title,
    required this.onTap, // Updated constructor to include onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap with GestureDetector to add onTap functionality
      onTap: onTap, // Assign onTap callback
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width / 2.3,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 28,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
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