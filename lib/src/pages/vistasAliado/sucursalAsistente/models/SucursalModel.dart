// To parse this JSON data, do
//
//     final sucursalesModel = sucursalesModelFromJson(jsonString);

import 'dart:convert';

SucursalesModel sucursalesModelFromJson(String str) => SucursalesModel.fromJson(json.decode(str));

String sucursalesModelToJson(SucursalesModel data) => json.encode(data.toJson());

class SucursalesModel {
    SucursalesModel({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    Data data;
    String message;

    factory SucursalesModel.fromJson(Map<String, dynamic> json) => SucursalesModel(
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
        this.id,
        this.nombre,
        this.direccion,
        this.latitude,
        this.longitude,
        this.estado,
        this.urlFotoPerfil,
        this.urlFotoPortada,
        this.telefono,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.idAsistente,
        this.idAliado,
    });

    int id;
    String nombre;
    String direccion;
    double latitude;
    double longitude;
    String estado;
    String urlFotoPerfil;
    String urlFotoPortada;
    int telefono;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;
    String idAsistente;
    String idAliado;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id:json["id"]==null?null:int.parse(json["id"].toString()),
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude: double.parse(json["latitude"].toString()),
        longitude: double.parse(json["longitude"]),
        estado: json["estado"],
        urlFotoPerfil: json["url_foto_perfil"],
        urlFotoPortada: json["url_foto_portada"],
        telefono:json["telefono"]==null?null:int.parse(json["telefono"].toString()),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idAsistente: json["id_asistente"],
        idAliado: json["id_aliado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "estado": estado,
        "url_foto_perfil": urlFotoPerfil,
        "url_foto_portada": urlFotoPortada,
        "telefono": telefono,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id_asistente": idAsistente,
        "id_aliado": idAliado,
    };
}
