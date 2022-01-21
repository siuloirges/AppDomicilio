// To parse this JSON data, do
//
//     final tipoVehiculoModel = tipoVehiculoModelFromJson(jsonString);

import 'dart:convert';

TipoVehiculoModel tipoVehiculoModelFromJson(String str) => TipoVehiculoModel.fromJson(json.decode(str));

String tipoVehiculoModelToJson(TipoVehiculoModel data) => json.encode(data.toJson());

class TipoVehiculoModel {
    TipoVehiculoModel({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    List<Datum> data;
    String message;

    factory TipoVehiculoModel.fromJson(Map<String, dynamic> json) => TipoVehiculoModel(
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
    dynamic createdAt;
    dynamic updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id:json["id"]==null?null:int.parse( json["id"].toString()),
        nombre: json["nombre"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
