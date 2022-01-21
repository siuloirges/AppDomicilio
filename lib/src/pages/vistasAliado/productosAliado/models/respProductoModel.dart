// To parse this JSON data, do
//
//     final respProductoModel = respProductoModelFromJson(jsonString);

import 'dart:convert';

RespProductoModel respProductoModelFromJson(String str) => RespProductoModel.fromJson(json.decode(str));

String respProductoModelToJson(RespProductoModel data) => json.encode(data.toJson());

class RespProductoModel {
    RespProductoModel({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    Data data;
    String message;

    factory RespProductoModel.fromJson(Map<String, dynamic> json) => RespProductoModel(
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
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    int currentPage;
    List<Datum> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    dynamic nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: int.parse(json["from"].toString()),
        lastPage: int.parse(json["last_page"].toString()),
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage:int.parse(json["per_page"].toString()),
        prevPageUrl: json["prev_page_url"],
        to: int.parse(json["to"].toString()), 
        total: int.parse(json["total"].toString()), 
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    Datum({
        this.id,
        this.titulo,
        this.codigo,
        this.descripcion,
        this.precio,
        this.disponibilidad,
        this.existencia,
        this.isCombo,
        this.isPromo,
        this.precioPromo,
        this.descripcionPromo,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.idAliado,
        this.idCategoriaProducto,
    });

    int id;
    String titulo;
    String codigo;
    String descripcion;
    String precio;
    int disponibilidad;
    int existencia;
    int isCombo;
    int isPromo;
    String precioPromo;
    dynamic descripcionPromo;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;
    String idAliado;
    String idCategoriaProducto;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: int.parse(json["id"].toString()),
        titulo: json["titulo"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        precio: json["precio"].toString(),
        disponibilidad:int.parse( json["disponibilidad"].toString()),
        existencia:int.parse( json["existencia"].toString()),
        isCombo: int.parse(json["is_combo"] == null ? null : json["is_combo"].toString()),
        isPromo:int.parse( json["is_promo"] == null ? null : json["is_promo"].toString()),
        precioPromo: json["precio_promo"] == null ? null : json["precio_promo"],
        descripcionPromo: json["descripcion_promo"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idAliado: json["id_aliado"],
        idCategoriaProducto: json["id_categoria_producto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "codigo": codigo,
        "descripcion": descripcion,
        "precio": precio,
        "disponibilidad": disponibilidad,
        "existencia": existencia,
        "is_combo": isCombo == null ? null : isCombo,
        "is_promo": isPromo == null ? null : isPromo,
        "precio_promo": precioPromo == null ? null : precioPromo,
        "descripcion_promo": descripcionPromo,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id_aliado": idAliado,
        "id_categoria_producto": idCategoriaProducto,
    };
}
