// To parse this JSON data, do
//
//     final homeAsistenteModel = homeAsistenteModelFromJson(jsonString);

import 'dart:convert';

HomeAsistenteModel homeAsistenteModelFromJson(String str) => HomeAsistenteModel.fromJson(json.decode(str));

String homeAsistenteModelToJson(HomeAsistenteModel data) => json.encode(data.toJson());

class HomeAsistenteModel {
    HomeAsistenteModel({
        this.success,
        this.nombre,
        this.estado,
        this.urlFotoPerfil,
        this.generadas,
        this.autorizada,
        this.preparada,
        this.entregada,
        this.cancelada,
        this.message,
    });

    bool success;
    String nombre;
    String estado;
    String urlFotoPerfil;
    int generadas;
    int autorizada;
    int preparada;
    int entregada;
    int cancelada;
    String message;

    factory HomeAsistenteModel.fromJson(Map<String, dynamic> json) => HomeAsistenteModel(
        success: json["success"],
        nombre: json["nombre"],
        estado: json["estado"],
        urlFotoPerfil: json["url_foto_perfil"],
        generadas: int.parse(json["generadas"].toString()),
        autorizada:int.parse( json["autorizada"].toString()),
        preparada:int.parse( json["preparada"].toString()),
        entregada:int.parse( json["entregada"].toString()),
        cancelada: int.parse(json["cancelada"].toString()),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "nombre": nombre,
        "estado": estado,
        "url_foto_perfil": urlFotoPerfil,
        "generadas": generadas,
        "autorizada": autorizada,
        "preparada": preparada,
        "entregada": entregada,
        "cancelada": cancelada,
        "message": message,
    };
}