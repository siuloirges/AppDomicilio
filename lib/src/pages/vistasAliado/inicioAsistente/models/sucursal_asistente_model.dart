// To parse this JSON data, do
//
//     final respuestaSucursalAsistente = respuestaSucursalAsistenteFromJson(jsonString);

import 'dart:convert';

RespuestaSucursalAsistente respuestaSucursalAsistenteFromJson(String str) => RespuestaSucursalAsistente.fromJson(json.decode(str));

String respuestaSucursalAsistenteToJson(RespuestaSucursalAsistente data) => json.encode(data.toJson());

class RespuestaSucursalAsistente {
    RespuestaSucursalAsistente({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    Data data;
    String message;

    factory RespuestaSucursalAsistente.fromJson(Map<String, dynamic> json) => RespuestaSucursalAsistente(
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
    String idAliado;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: int.parse(json["id"].toString()),
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        estado: json["estado"],
        urlFotoPerfil: json["url_foto_perfil"],
        urlFotoPortada: json["url_foto_portada"],
        telefono: int.parse(json["telefono"].toString()),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "id_aliado": idAliado,
    };
}
