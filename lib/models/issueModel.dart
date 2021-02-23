// To parse this JSON data, do
//
//     final issue = issueFromJson(jsonString);

import 'dart:convert';

List<Issue> issueFromJson(String str) =>
    List<Issue>.from(json.decode(str).map((x) => Issue.fromJson(x)));

String issueToJson(List<Issue> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Issue {
  Issue({
    this.id,
    this.htmlUrl,
    this.title,
    this.user,
  });

  int id;
  String htmlUrl;
  String title;
  User user;

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        id: json["id"],
        htmlUrl: json["html_url"],
        title: json["title"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "html_url": htmlUrl,
        "title": title,
        "user": user.toJson(),
      };

  @override
  String toString() => '$title';
}

class User {
  User({
    this.login,
  });

  String login;

  factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
      };
}
