// To parse this JSON data, do
//
//     final resMisOrdenes = resMisOrdenesFromJson(jsonString);

import 'dart:convert';

ResMisOrdenes resMisOrdenesFromJson(String str) => ResMisOrdenes.fromJson(json.decode(str));

String resMisOrdenesToJson(ResMisOrdenes data) => json.encode(data.toJson());

class ResMisOrdenes {
    ResMisOrdenes({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    Data data;
    String message;

    factory ResMisOrdenes.fromJson(Map<String, dynamic> json) => ResMisOrdenes(
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
    List<OrdenesC> data;
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
        data: List<OrdenesC>.from(json["data"].map((x) => OrdenesC.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: int.parse(json["from"].toString()),
        lastPage:int.parse( json["last_page"].toString()),
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: int.parse(json["per_page"].toString()),
        prevPageUrl: json["prev_page_url"],
        to:int.parse( json["to"].toString()),
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

class OrdenesC {
    OrdenesC({
        this.id,
        this.numeroPedido,
        this.generada,
        this.autorizada,
        this.preparada,
        this.entregada,
        this.cancelada,
        this.metodoDePago,
        this.precioTotal,
        this.motivoAnulacion,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.aliadoId,
        this.direccionId,
        this.sucursalId,
        this.clienteId,
        this.repartidorId,
        this.aliado,
        this.fotoAliado,
        this.sucursal,
        this.direccionSucursal,
        this.direccion,
    });

    int id;
    String numeroPedido;
    dynamic generada;
    dynamic autorizada;
    dynamic preparada;
    dynamic entregada;
    dynamic cancelada;
    String metodoDePago;
    String precioTotal;
    dynamic motivoAnulacion;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;
    int aliadoId;
    int direccionId;
    int sucursalId;
    int clienteId;
    dynamic repartidorId;
    String aliado;
    String fotoAliado;
    String sucursal;
    String direccionSucursal;
    DireccionC direccion;

    factory OrdenesC.fromJson(Map<String, dynamic> json) => OrdenesC(
        id: json["id"]==null?null:int.parse(json["id"].toString()),
        numeroPedido: json["numero_pedido"],
        generada: json["generada"],
        autorizada: json["autorizada"],
        preparada: json["preparada"],
        entregada: json["entregada"],
        cancelada: json["cancelada"],
        metodoDePago: json["metodo_de_pago"],
        precioTotal: json["precio_total"],
        motivoAnulacion: json["motivo_anulacion"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        aliadoId: json["aliado_id"]==null?null:int.parse(json["aliado_id"].toString()),
        direccionId: json["direccion_id"]==null?null:int.parse(json["direccion_id"].toString()),
        sucursalId:json["sucursal_id"]==null?null: int.parse(json["sucursal_id"].toString()),
        clienteId: json["cliente_id"]==null?null:int.parse(json["cliente_id"].toString()),
        repartidorId: json["repartidor_id"],
        aliado: json["aliado"],
        fotoAliado: json["foto_aliado"],
        sucursal: json["sucursal"],
        direccionSucursal: json["direccion_sucursal"],
        direccion: DireccionC.fromJson(json["direccion"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "numero_pedido": numeroPedido,
        "generada": generada,
        "autorizada": autorizada,
        "preparada": preparada,
        "entregada": entregada,
        "cancelada": cancelada,
        "metodo_de_pago": metodoDePago,
        "precio_total": precioTotal,
        "motivo_anulacion": motivoAnulacion,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "aliado_id": aliadoId,
        "direccion_id": direccionId,
        "sucursal_id": sucursalId,
        "cliente_id": clienteId,
        "repartidor_id": repartidorId,
        "aliado": aliado,
        "foto_aliado": fotoAliado,
        "sucursal": sucursal,
        "direccion_sucursal": direccionSucursal,
        "direccion": direccion.toJson(),
    };
}

class DireccionC {
    DireccionC({
        this.id,
        this.nombre,
        this.direccion,
        this.latitude,
        this.longitude,
        this.referencia,
        this.tipoDirecionId,
        this.deletedAt,
        this.usuarioId,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String nombre;
    String direccion;
    double latitude;
    double longitude;
    dynamic referencia;
    String tipoDirecionId;
    dynamic deletedAt;
    int usuarioId;
    DateTime createdAt;
    DateTime updatedAt;

    factory DireccionC.fromJson(Map<String, dynamic> json) => DireccionC(
        id: json["id"]==null?null:int.parse( json["id"].toString()),
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude: json["latitude"]==null?null:double.parse(json["latitude"].toString()),
        longitude:json["longitude"]==null?null:double.parse(json["longitude"].toString()),
        referencia: json["referencia"],
        tipoDirecionId: json["tipo_direcion_id"],
        deletedAt: json["deleted_at"],
        usuarioId: json["usuario_id"]==null?null:int.parse( json["usuario_id"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccionC": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "referencia": referencia,
        "tipo_direcion_id": tipoDirecionId,
        "deleted_at": deletedAt,
        "usuario_id": usuarioId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
