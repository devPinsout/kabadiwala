// To parse this JSON data, do
//
//     final cancelReasonModel = cancelReasonModelFromJson(jsonString);

import 'dart:convert';

List<CancelReasonModel> cancelReasonModelFromJson(String str) => List<CancelReasonModel>.from(json.decode(str).map((x) => CancelReasonModel.fromJson(x)));

String cancelReasonModelToJson(List<CancelReasonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CancelReasonModel {
    int? id;
    String? cancellationReasons;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    CancelReasonModel({
        this.id,
        this.cancellationReasons,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory CancelReasonModel.fromJson(Map<String, dynamic> json) => CancelReasonModel(
        id: json["id"],
        cancellationReasons: json["cancellation_reasons"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cancellation_reasons": cancellationReasons,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
