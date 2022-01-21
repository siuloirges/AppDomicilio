// To parse this JSON data, do
//
//     final tipoDocumentoModel = tipoDocumentoModelFromJson(jsonString);

import 'dart:convert';

TipoDocumentoModel tipoDocumentoModelFromJson(String str) => TipoDocumentoModel.fromJson(json.decode(str));

String tipoDocumentoModelToJson(TipoDocumentoModel data) => json.encode(data.toJson());

class TipoDocumentoModel {
    TipoDocumentoModel({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    List<Datum> data;
    String message;

    factory TipoDocumentoModel.fromJson(Map<String, dynamic> json) => TipoDocumentoModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    Datum({
        this.id,
        this.nombre,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String nombre;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"]==null?null:int.parse(json["id"].toString()),
        nombre: json["nombre"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
