// To parse this JSON data, do
//


import 'dart:convert';

TipoDireccion tipoDireccionFromJson(String str) => TipoDireccion.fromJson(json.decode(str));

String tipoDireccionToJson(TipoDireccion data) => json.encode(data.toJson());

class TipoDireccion {
    TipoDireccion({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    Data data;
    String message;

    factory TipoDireccion.fromJson(Map<String, dynamic> json) => TipoDireccion(
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
        currentPage:int.parse( json["current_page"].toString()),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: int.parse(json["from"].toString()),
        lastPage:int.parse( json["last_page"].toString()),
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: int.parse(json["per_page"].toString()),
        prevPageUrl: json["prev_page_url"],
        to: int.tryParse(json["to"].toString()),
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
        this.icono,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String icono;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"]==null?null:int.parse(json["id"].toString()),
        icono: json["icono"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "icono": icono,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
