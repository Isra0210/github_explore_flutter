import 'package:flutter/material.dart';
import 'package:github_repository/models/repositoryModel.dart';
import 'package:github_repository/widget/repositoryWidget.dart';

class RepositoryListWidget extends StatefulWidget {
  final List<Repository> repositoryList;

  RepositoryListWidget({this.repositoryList});

  @override
  _RepositoryListWidgetState createState() => _RepositoryListWidgetState();
}

class _RepositoryListWidgetState extends State<RepositoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        children: widget.repositoryList.map((repos) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: RepositoryWidget(repository: repos),
          );
        }).toList(),
      ),
    );
  }
}
