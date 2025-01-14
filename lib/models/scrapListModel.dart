// To parse this JSON data, do
//
//     final scrapListModel = scrapListModelFromJson(jsonString);

import 'dart:convert';

List<ScrapListModel> scrapListModelFromJson(String str) => List<ScrapListModel>.from(json.decode(str).map((x) => ScrapListModel.fromJson(x)));

String scrapListModelToJson(List<ScrapListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScrapListModel {
    int? id;
    String? scrapName;
    int? categoryId;
    int? icon;
    int? price;
    String? unit;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    int? status;
    String? scrapIconUrl;
    dynamic scrapIconAltText;
    String? categoryName;
    String? url;
    dynamic categoryIconAltText;

    ScrapListModel({
        this.id,
        this.scrapName,
        this.categoryId,
        this.icon,
        this.price,
        this.unit,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.status,
        this.scrapIconUrl,
        this.scrapIconAltText,
        this.categoryName,
        this.url,
        this.categoryIconAltText,
    });

    factory ScrapListModel.fromJson(Map<String, dynamic> json) => ScrapListModel(
        id: json["id"],
        scrapName: json["scrap_name"],
        categoryId: json["category_id"],
        icon: json["icon"],
        price: json["price"],
        unit: json["unit"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        status: json["status"],
        scrapIconUrl: json["scrap_icon_url"],
        scrapIconAltText: json["scrap_icon_alt_text"],
        categoryName: json["category_name"],
        url: json["url"],
        categoryIconAltText: json["category_icon_alt_text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "scrap_name": scrapName,
        "category_id": categoryId,
        "icon": icon,
        "price": price,
        "unit": unit,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "status": status,
        "scrap_icon_url": scrapIconUrl,
        "scrap_icon_alt_text": scrapIconAltText,
        "category_name": categoryName,
        "url": url,
        "category_icon_alt_text": categoryIconAltText,
    };
}
