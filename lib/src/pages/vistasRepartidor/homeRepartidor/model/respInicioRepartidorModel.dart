// To parse this JSON data, do
//
//     final respInicioRepartidorModel = respInicioRepartidorModelFromJson(jsonString);

import 'dart:convert';

RespInicioRepartidorModel respInicioRepartidorModelFromJson(String str) => RespInicioRepartidorModel.fromJson(json.decode(str));

String respInicioRepartidorModelToJson(RespInicioRepartidorModel data) => json.encode(data.toJson());

class RespInicioRepartidorModel {
    RespInicioRepartidorModel({
        this.success,
        this.autorizada,
        this.enTransito,
        this.entregada,
        this.data,
        this.message,
    });

    bool success;
    int autorizada;
    int enTransito;
    int entregada;
    String data;
    String message;

    factory RespInicioRepartidorModel.fromJson(Map<String, dynamic> json) => RespInicioRepartidorModel(
        success: json["success"],
        autorizada: int.parse(json["autorizada"].toString()),
        enTransito: int.parse(json["en_transito"].toString()),
        entregada: int.parse(json["entregada"].toString()),
        data: json["data"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "autorizada": autorizada,
        "en_transito": enTransito,
        "entregada": entregada,
        "data": data,
        "message": message,
    };
}