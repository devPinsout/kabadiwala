// To parse this JSON data, do
//
//     final scrapCategoryModel = scrapCategoryModelFromJson(jsonString);

import 'dart:convert';

List<ScrapCategoryModel> scrapCategoryModelFromJson(String str) => List<ScrapCategoryModel>.from(json.decode(str).map((x) => ScrapCategoryModel.fromJson(x)));

String scrapCategoryModelToJson(List<ScrapCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScrapCategoryModel {
    int? id;
    String? categoryName;
    int? icon;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    int? status;
    String? url;
    dynamic altText;

    ScrapCategoryModel({
        this.id,
        this.categoryName,
        this.icon,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.status,
        this.url,
        this.altText,
    });

    factory ScrapCategoryModel.fromJson(Map<String, dynamic> json) => ScrapCategoryModel(
        id: json["id"],
        categoryName: json["category_name"],
        icon: json["icon"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        status: json["status"],
        url: json["url"],
        altText: json["alt_text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "icon": icon,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "status": status,
        "url": url,
        "alt_text": altText,
    };
}
