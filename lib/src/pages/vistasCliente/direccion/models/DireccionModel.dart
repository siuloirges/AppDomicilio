// To parse this JSON data, do
//
//     final direccionModel = direccionModelFromJson(jsonString);

import 'dart:convert';

DireccionModel direccionModelFromJson(String str) =>
    DireccionModel.fromJson(json.decode(str));

String direccionModelToJson(DireccionModel data) => json.encode(data.toJson());

class DireccionModel {
  DireccionModel({
    this.nombre,
    this.direccion,
    this.latitude,
    this.longitude,
    this.usuarioId,
    this.tipoDireccion,
    this.referencia,
  });

  String nombre;
  String direccion;
  double latitude;
  double longitude;
  String usuarioId;
  String tipoDireccion;
  String referencia;

  factory DireccionModel.fromJson(Map<String, dynamic> json) => DireccionModel(
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude:json["latitude"]==null?null: double.parse(json["latitude"].toString()),
        longitude: json["longitude"]==null?null:double.parse(json["longitude"].toString()),
        usuarioId: json["usuario_id"],
        tipoDireccion: json["tipo_direccion"],
        referencia: json["referencia"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "usuario_id": usuarioId,
        "tipo_direccion": tipoDireccion,
        "referencia": referencia,
      };
}
