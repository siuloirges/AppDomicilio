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
    List<Vehiculo> data;
    String message;

    factory TipoVehiculoModel.fromJson(Map<String, dynamic> json) => TipoVehiculoModel(
        success: json["success"],
        data: List<Vehiculo>.from(json["data"].map((x) => Vehiculo.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Vehiculo {
    Vehiculo({
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

    factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        id: int.parse(json["id"].toString()),
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
