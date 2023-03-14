import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
part 'clientModel.g.dart';

ClientModel clientModelFromJson(String str) =>
    ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class ClientModel extends HiveObject {
  ClientModel({
    required this.name,
    required this.phone,
    required this.address,
    this.postcode,
    required this.ownerId,
    this.isSync,
  });

  @HiveField(0)
  String name;
  @HiveField(1)
  String phone;
  @HiveField(2)
  String address;
  @HiveField(3)
  String? postcode;
  @HiveField(4)
  String ownerId;
  @HiveField(5, defaultValue: false)
  bool? isSync;
  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        postcode: json["postcode"],
        ownerId: json["ownerId"],
        isSync: json["isSync"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "address": address,
        "postcode": postcode,
        "ownerId": ownerId,
        "isSync": isSync,
      };
}
