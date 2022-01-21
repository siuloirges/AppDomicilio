// To parse this JSON data, do
//
//     final respAliadoModel = respAliadoModelFromJson(jsonString);

import 'dart:convert';

RespAliadoModel respAliadoModelFromJson(String str) => RespAliadoModel.fromJson(json.decode(str));

String respAliadoModelToJson(RespAliadoModel data) => json.encode(data.toJson());

class RespAliadoModel {
    RespAliadoModel({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    Data data;
    String message;

    factory RespAliadoModel.fromJson(Map<String, dynamic> json) => RespAliadoModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        this.nombre,
        this.razonSocial,
        this.nit,
        this.urlFotoPortada,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String nombre;
    String razonSocial;
    String nit;
    dynamic urlFotoPortada;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        nombre: json["nombre"],
        razonSocial: json["razon_social"],
        nit: json["nit"],
        urlFotoPortada: json["url_foto_portada"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id:json["id"]==null?null: int.parse(json["id"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "razon_social": razonSocial,
        "nit": nit,
        "url_foto_portada": urlFotoPortada,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}