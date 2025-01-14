// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
    int? id;
    int? userId;
    String? placeType;
    String? street;
    String? subLocality;
    String? city;
    String? state;
    String? pincode;
    String? latitude;
    String? longitude;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    AddressModel({
        this.id,
        this.userId,
        this.placeType,
        this.street,
        this.subLocality,
        this.city,
        this.state,
        this.pincode,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        userId: json["user_id"],
        placeType: json["place_type"],
        street: json["street"],
        subLocality: json["sub_locality"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "place_type": placeType,
        "street": street,
        "sub_locality":subLocality,
        "city": city,
        "state": state,
        "pincode": pincode,
         "latitude": latitude,
          "longitude": longitude,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
