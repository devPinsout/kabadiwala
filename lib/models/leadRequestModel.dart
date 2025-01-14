// To parse this JSON data, do
//
//     final leadRequestModel = leadRequestModelFromJson(jsonString);

import 'dart:convert';

List<LeadRequestModel> leadRequestModelFromJson(String str) => List<LeadRequestModel>.from(json.decode(str).map((x) => LeadRequestModel.fromJson(x)));

String leadRequestModelToJson(List<LeadRequestModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeadRequestModel {
    int? id;
    int? userId;
    int? addressId;
    String? placeType;
    String? address;
    String? latitude;
    String? longitude;
    DateTime? pickupDate;
    int? orderProgress;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    int? status;
    List<ScrapItem>? scrapItems;

    LeadRequestModel({
        this.id,
        this.userId,
        this.addressId,
        this.placeType,
        this.address,
        this.latitude,
        this.longitude,
        this.pickupDate,
        this.orderProgress,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.status,
        this.scrapItems,
    });

    factory LeadRequestModel.fromJson(Map<String, dynamic> json) => LeadRequestModel(
        id: json["id"],
        userId: json["user_id"],
        addressId: json["address_id"],
        placeType: json["place_type"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        pickupDate: json["pickup_date"] == null ? null : DateTime.parse(json["pickup_date"]),
        orderProgress: json["order_progress"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        status: json["status"],
        scrapItems: json["scrap_items"] == null ? [] : List<ScrapItem>.from(json["scrap_items"]!.map((x) => ScrapItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address_id": addressId,
        "place_type": placeType,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "pickup_date": "${pickupDate!.year.toString().padLeft(4, '0')}-${pickupDate!.month.toString().padLeft(2, '0')}-${pickupDate!.day.toString().padLeft(2, '0')}",
        "order_progress": orderProgress,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "status": status,
        "scrap_items": scrapItems == null ? [] : List<dynamic>.from(scrapItems!.map((x) => x.toJson())),
    };
}

class ScrapItem {
    int? id;
    int? orderId;
    String? scrapName;
    int? price;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    ScrapItem({
        this.id,
        this.orderId,
        this.scrapName,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory ScrapItem.fromJson(Map<String, dynamic> json) => ScrapItem(
        id: json["id"],
        orderId: json["order_id"],
        scrapName: json["scrap_name"],
        price: json["price"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "scrap_name": scrapName,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
