import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gitpod/gitlist/git_tile1.dart';
import 'package:gitpod/gitlist/git_tile2.dart';
import 'package:http/http.dart' as http;
import 'git_model.dart';

enum ProjectStatus { all, inProgress, completed, canceled }

class GitList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoriesAsyncValue = ref.watch(repositoriesProvider);
    final selectedStatus = ref.watch(selectedStatusProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Daily Task",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              DropdownButton<ProjectStatus>(
                underline: SizedBox(),
                icon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                value: ref.watch(selectedStatusProvider),
                onChanged: (newValue) {
                  ref.read(selectedStatusProvider.notifier).state = newValue!;
                },
                items: ProjectStatus.values.map((status) {
                  String statusText;
                  switch (status) {
                    case ProjectStatus.all:
                      statusText = 'All Task';
                      break;
                    case ProjectStatus.inProgress:
                      statusText = 'In Progress';
                      break;
                    case ProjectStatus.completed:
                      statusText = 'Completed';
                      break;
                    case ProjectStatus.canceled:
                      statusText = 'Canceled';
                      break;
                  }
                  return DropdownMenuItem<ProjectStatus>(
                    value: status,
                    child: Text(statusText),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        repositoriesAsyncValue.when(
          loading: () => Center(
            child:
                CircularProgressIndicator(), // Display circular progress indicator while loading
          ),
          error: (error, stackTrace) => Center(
            child:
                Text('Error: $error'), // Display error message if error occurs
          ),
          data: (repositories) {
            final filteredRepositories =
                _filterRepositories(repositories, selectedStatus);
            return filteredRepositories.isEmpty
                ? Center(
                    child: Text('No repositories found'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredRepositories.length,
                    itemBuilder: (context, index) {
                      final repository = filteredRepositories[index];
                      return GitTile1(gitModel: repository);
                    },
                  );
          },
        ),
      ],
    );
  }

  List<GitModel> _filterRepositories(
      List<GitModel>? repositories, ProjectStatus selectedStatus) {
    if (repositories == null) return [];

    switch (selectedStatus) {
      case ProjectStatus.all:
        return repositories;
      case ProjectStatus.inProgress:
        return repositories.where((repo) => repo.openIssuesCount != 0).toList();
      case ProjectStatus.completed:
        return repositories.where((repo) => repo.openIssuesCount == 0).toList();
      case ProjectStatus.canceled:
        return repositories.where((repo) => repo.disabled == true).toList();
      default:
        return [];
    }
  }
}

final selectedStatusProvider =
    StateProvider<ProjectStatus>((ref) => ProjectStatus.all);

final repositoriesProvider = FutureProvider<List<GitModel>>((ref) async {
  final response = await http.get(Uri.parse(
      "https://api.github.com/search/repositories?q=sort=stars&order=desc"));
  if (response.statusCode == 200) {
    final List<dynamic> repositoriesJson = json.decode(response.body)['items'];
    return repositoriesJson
        .map((repoJson) => GitModel.fromJson(repoJson))
        .toList();
  } else {
    throw Exception('Failed to load repositories');
  }
});

class SelectedGitList extends ConsumerWidget {
  final ProjectStatus selectedStatus;

  SelectedGitList({required this.selectedStatus});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoriesAsyncValue = ref.watch(repositoriesProvider);

    return SingleChildScrollView(
      child: repositoriesAsyncValue.when(
        loading: () => Center(
          child:
              CircularProgressIndicator(), // Display circular progress indicator while loading
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'), // Display error message if error occurs
        ),
        data: (repositories) {
          final filteredRepositories =
              _filterRepositories(repositories, selectedStatus);
          return filteredRepositories.isEmpty
              ? Center(
                  child: Text('No repositories found'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredRepositories.length,
                  itemBuilder: (context, index) {
                    final repository = filteredRepositories[index];
                    return GitTile2(gitModel: repository);
                  },
                );
        },
      ),
    );
  }

  List<GitModel> _filterRepositories(
      List<GitModel>? repositories, ProjectStatus selectedStatus) {
    if (repositories == null) return [];

    switch (selectedStatus) {
      case ProjectStatus.all:
        return repositories;
      case ProjectStatus.inProgress:
        return repositories.where((repo) => repo.openIssuesCount != 0).toList();
      case ProjectStatus.completed:
        return repositories.where((repo) => repo.openIssuesCount == 0).toList();
      case ProjectStatus.canceled:
        return repositories.where((repo) => repo.disabled == true).toList();
      default:
        return [];
    }
  }
}

// Other parts of your code remain the same
