import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gitpod/gitlist/git_list.dart';
import 'package:gitpod/category/category_grid.dart';
import 'package:gitpod/category/category_grid.dart';
import 'package:gitpod/home/home_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                HeadAppBar(),
                NameWidget(),
                CategoryGrid(),
                GitList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
