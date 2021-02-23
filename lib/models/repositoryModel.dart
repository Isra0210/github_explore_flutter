import 'dart:convert';

Repository repositoryFromJson(String str) =>
    Repository.fromJson(json.decode(str));

String repositoryToJson(Repository data) => json.encode(data.toJson());

class Repository {
  Repository({
    this.fullName,
    this.owner,
    this.description,
  });

  String fullName;
  Owner owner;
  String description;

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        fullName: json["full_name"],
        owner: Owner.fromJson(json["owner"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "owner": owner.toJson(),
        "description": description,
      };
}

class Owner {
  Owner({
    this.login,
    this.avatarUrl,
  });

  String login;
  String avatarUrl;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"],
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "avatar_url": avatarUrl,
      };
}
