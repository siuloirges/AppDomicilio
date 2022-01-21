// To parse this JSON data, do
//
//     final getRespWallet = getRespWalletFromMap(jsonString);

import 'dart:convert';

GetRespWallet getRespWalletFromMap(String str) => GetRespWallet.fromMap(json.decode(str));

String getRespWalletToMap(GetRespWallet data) => json.encode(data.toMap());

class GetRespWallet {
    GetRespWallet({
        this.success,
        this.data,
        this.movimientos,
        this.nuevo,
        this.message,
    });

    bool success;
    Data data;
    List<Movimiento> movimientos;
    bool nuevo;
    String message;

    factory GetRespWallet.fromMap(Map<String, dynamic> json) => GetRespWallet(
        success: json["success"],
        data: Data.fromMap(json["data"]),
        movimientos: List<Movimiento>.from(json["movimientos"].map((x) => Movimiento.fromMap(x))),
        nuevo: json["nuevo"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
        "movimientos": List<dynamic>.from(movimientos.map((x) => x.toMap())),
        "nuevo": nuevo,
        "message": message,
    };
}

class Data {
    Data({
        this.id,
        this.saldoActual,
        this.creditoActual,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.idRepartidor,
    });

    int id;
    dynamic saldoActual;
    dynamic creditoActual;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String idRepartidor;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: int.parse(json["id"].toString()),
        saldoActual: json["saldo_actual"],
        creditoActual: json["credito_actual"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        idRepartidor: json["id_repartidor"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "saldo_actual": saldoActual,
        "credito_actual": creditoActual,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "id_repartidor": idRepartidor,
    };
}

class Movimiento {
    Movimiento({
        this.id,
        this.valorMovimiento,
        this.tipoMovimiento,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.idWallet,
        this.idRepartidor,
    });

    int id;
    int valorMovimiento;
    String tipoMovimiento;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String idWallet;
    String idRepartidor;

    factory Movimiento.fromMap(Map<String, dynamic> json) => Movimiento(
        id: int.parse(json["id"].toString()),
        valorMovimiento: int.parse(json["valor_movimiento"].toString()),
        tipoMovimiento: json["tipo_movimiento"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        idWallet: json["id_wallet"],
        idRepartidor: json["id_repartidor"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "valor_movimiento": valorMovimiento,
        "tipo_movimiento": tipoMovimiento,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "id_wallet": idWallet,
        "id_repartidor": idRepartidor,
    };
}