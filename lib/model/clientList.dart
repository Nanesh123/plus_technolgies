import 'dart:convert';

ClientListModel clientListModelFromJson(String str) =>
    ClientListModel.fromJson(json.decode(str));

String clientListModelToJson(ClientListModel data) =>
    json.encode(data.toJson());

class ClientListModel {
  ClientListModel({
    this.data,
    this.message,
  });

  final List<ClientList>? data;
  final String? message;

  factory ClientListModel.fromJson(Map<String, dynamic> json) =>
      ClientListModel(
        data: json["data"] == null
            ? []
            : List<ClientList>.from(
                json["data"]!.map((x) => ClientList.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class ClientList {
  ClientList({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.postcode,
    this.ownerId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.buildings,
  });

  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final dynamic postcode;
  final int? ownerId;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic>? buildings;

  factory ClientList.fromJson(Map<String, dynamic> json) => ClientList(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        postcode: json["postcode"],
        ownerId: json["owner_id"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        buildings: json["buildings"] == null
            ? []
            : List<dynamic>.from(json["buildings"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "postcode": postcode,
        "owner_id": ownerId,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "buildings": buildings == null
            ? []
            : List<dynamic>.from(buildings!.map((x) => x)),
      };
}
