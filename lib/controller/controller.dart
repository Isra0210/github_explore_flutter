import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:github_repository/models/repositoryModel.dart';
import 'package:github_repository/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Controller extends GetxController {
  Rx<Repository> repositoryRx = Rx<Repository>();
  RxInt counter = 0.obs;
  Repository get repository => repositoryRx.value;
  set repository(Repository repository) => repositoryRx.value = repository;

  Rx<List<Repository>> repositoryListRx = Rx<List<Repository>>();
  List<Repository> get repositoryList => repositoryListRx.value;
  set repositoryList(List<Repository> repositoryList) =>
      repositoryListRx.value = repositoryList;

  Future<Repository> getRepositoyInfo({String searchRepos}) async {
    try {
      http.Response response;
      response = await http.get("$BASE_URL/repos/$searchRepos");
      repository = Repository.fromJson(jsonDecode(response.body));
      return repository;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future getIssueInfo(String searchIssue) async {
    try {
      http.Response response;
      response =
          await http.get("https://api.github.com/repos/$searchIssue/issues");
      return json.decode(response.body);
    } catch (error) {
      return null;
    }
  }

  openSnackBarController({String title, String text}) {
    return Get.snackbar(title, text);
  }

  openBrowserController({String url}) async {
    try {
      String newUrl = url;
      if (await canLaunch(newUrl)) {
        await launch(newUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (error) {
      print(error);
    }
  }
}
