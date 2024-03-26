import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gitpod/home/home_appbar.dart';
import 'package:gitpod/gitlist/git_list.dart'; // Import the GitList widget

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadAppBar(),
              PageAppBar(title: "Project"),
              Expanded(
                child: ProjectsTabs(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectsTabs extends StatefulWidget {
  @override
  _ProjectsTabsState createState() => _ProjectsTabsState();
}

class _ProjectsTabsState extends State<ProjectsTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.1,
                  blurRadius: 0.1,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
              child: Theme(
                data: theme.copyWith(
                  colorScheme: theme.colorScheme.copyWith(
                    surfaceVariant: Colors.transparent,
                  ),
                ),
                child: TabBar(
                  splashFactory: NoSplash.splashFactory,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Color.fromARGB(255, 142, 125, 255),
                  ),
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Ongoing'),
                    Tab(text: 'Completed'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SelectedGitList(selectedStatus: ProjectStatus.all),
                SelectedGitList(selectedStatus: ProjectStatus.inProgress),
                SelectedGitList(selectedStatus: ProjectStatus.completed),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
