import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repository/models/repositoryModel.dart';
import 'package:github_repository/screens/repositoryScreen.dart';

class RepositoryWidget extends StatefulWidget {
  final Repository repository;

  RepositoryWidget({this.repository});

  @override
  _RepositoryWidgetState createState() => _RepositoryWidgetState();
}

class _RepositoryWidgetState extends State<RepositoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => RepositoryScreen(
              repository: widget.repository,
            ),
          );
        },
        child: Container(
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: NetworkImage(
                      '${widget.repository.owner.avatarUrl}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 196,
                          child: Text(
                            '${widget.repository.fullName}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        widget.repository.description != null
                            ? Container(
                                width: 196,
                                child: Text(
                                  '${widget.repository.description}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_right, color: Colors.grey[900]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
