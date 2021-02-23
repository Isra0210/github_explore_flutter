import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repository/controller/controller.dart';
import 'package:github_repository/models/issueModel.dart';
import 'package:github_repository/models/repositoryModel.dart';
import 'package:github_repository/widget/iconGit.dart';

class RepositoryScreen extends StatefulWidget {
  final Repository repository;

  RepositoryScreen({this.repository});

  @override
  _RepositoryScreenState createState() => _RepositoryScreenState();
}

class _RepositoryScreenState extends State<RepositoryScreen> {
  Controller controller = Controller();
  List<Issue> issueList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 0.96),
      body: Stack(
        children: [
          Image.asset(
            'assets/icon.png',
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconGit(),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: FlatButton(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'voltar',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40.0,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: NetworkImage(
                              '${widget.repository.owner.avatarUrl}',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 220,
                                  child: Text(
                                    '${widget.repository.fullName}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey[800],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
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
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: controller.getIssueInfo(widget.repository.fullName),
                    builder: (context, snapshot) {
                      List issueList = snapshot.data;
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Container(
                            height: 200.0,
                            width: 200.0,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              strokeWidth: 4.0,
                            ),
                          );
                          break;
                        case ConnectionState.none:
                          return Center(
                            child: Text(
                              'Parece que algo deu errado!',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          );
                          break;

                        default:
                          if (snapshot.hasError) {
                            return Text(
                              'Algo deu errado!!',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            );
                          } else {
                            return Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Column(
                                children: issueList.map((issue) {
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: double.infinity,
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.openBrowserController(
                                              url: issue['html_url']),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${issue['title'] ?? ''}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                ),
                                                child: Text(
                                                  '${issue['user']['login'] ?? ''}',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
