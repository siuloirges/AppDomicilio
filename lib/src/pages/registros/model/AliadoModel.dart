// To parse this JSON data, do
//
//     final aliadoModel = aliadoModelFromJson(jsonString);

import 'dart:convert';

// import 'dart:io';

AliadoModel aliadoModelFromJson(String str) => AliadoModel.fromJson(json.decode(str));

String aliadoModelToJson(AliadoModel data) => json.encode(data.toJson());

class AliadoModel {
    AliadoModel({
        this.nit,
        this.razonSocial,
        this.nombre,
        this.urlFotoPortada,
        this.urlFotoPerfil,
    });

    String nit;
    String razonSocial;
    String nombre;
    dynamic urlFotoPortada;
    dynamic urlFotoPerfil;

    factory AliadoModel.fromJson(Map<String, dynamic> json) => AliadoModel(
        nit: json["nit"],
        razonSocial: json["razon_social"],
        nombre: json["nombre"],
        urlFotoPortada: json["url_foto_portada"],
        urlFotoPerfil: json["url_foto_perfil"],
    );

    Map<String, dynamic> toJson() => {
        "nit": nit,
        "razon_social": razonSocial,
        "nombre": nombre,
        "url_foto_portada": urlFotoPortada,
        "url_foto_perfil": urlFotoPerfil,
    };
}
