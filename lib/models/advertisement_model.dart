import 'dart:convert';

Advertisement advertisementFromJson(String str) => Advertisement.fromJson(json.decode(str));

String advertisementToJson(Advertisement data) => json.encode(data.toJson());

class Advertisement {
  int id;
  String title;
  String path;
  int homeAd;
  int? priority;
  int isImg;
  DateTime fromDate;
  DateTime toDate;
  DateTime createdAt;
  DateTime updatedAt;

  Advertisement({
    required this.id,
    required this.title,
    required this.path,
    required this.homeAd,
    required this.priority,
    required this.isImg,
    required this.fromDate,
    required this.toDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
    id: json["id"],
    title: json["title"],
    path: json["path"],
    homeAd: json["home_ad"],
    priority: json["priority"],
    isImg: json["is_img"],
    fromDate: DateTime.parse(json["from_date"]),
    toDate: DateTime.parse(json["to_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "path": path,
    "home_ad": homeAd,
    "priority": priority,
    "is_img": isImg,
    "from_date": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
    "to_date": "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}