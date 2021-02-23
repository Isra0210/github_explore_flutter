import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repository/controller/controller.dart';
import 'package:github_repository/widget/iconGit.dart';
import 'package:github_repository/widget/repositoryListWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Controller controller = Get.put(Controller());

  final TextEditingController textController = new TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 0.96),
      body: Stack(
        children: [
          Image.asset(
            'assets/icon.png',
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconGit(),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Explore repositórios no Github',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          key: keyForm,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            hintText: 'Digite o nome do repositório',
                          ),
                          cursorColor: Colors.black,
                          controller: textController,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Color.fromRGBO(4, 211, 97, 0.96),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Pesquisar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (textController.text.isEmpty) {
                            controller.openSnackBarController(
                              title: 'Erro ao buscar repositório',
                              text:
                                  'Busque por dono_repositório/nome_repositório',
                            );
                          } else {
                            controller
                                .getRepositoyInfo(
                                    searchRepos: textController.text)
                                .then((value) {
                              if (controller.repositoryList == null) {
                                controller.repositoryList = [];
                              }
                              setState(() {
                                controller.repositoryList.add(value);
                              });
                            });
                          }
                          textController.clear();
                        }),
                  ),
                  Obx(
                    () => controller.repositoryList != null &&
                            controller.repositoryList.length > 0
                        ? RepositoryListWidget(
                            repositoryList: controller.repositoryList,
                          )
                        : Container(),
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
