// To parse this JSON data, do
//
//     final respDetalleOrdenAsistente = respDetalleOrdenAsistenteFromJson(jsonString);

import 'dart:convert';

RespDetalleOrdenAsistente respDetalleOrdenAsistenteFromJson(String str) => RespDetalleOrdenAsistente.fromJson(json.decode(str));

String respDetalleOrdenAsistenteToJson(RespDetalleOrdenAsistente data) => json.encode(data.toJson());

class RespDetalleOrdenAsistente {
    RespDetalleOrdenAsistente({
        this.id,
        this.numeroPedido,
        this.estado,
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
        this.direccion,
        this.sucursal,
        this.cliente,
    });

    int id;
    String numeroPedido;
    String estado;
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
    Direccion direccion;
    Sucursal sucursal;
    Cliente cliente;

    factory RespDetalleOrdenAsistente.fromJson(Map<String, dynamic> json) => RespDetalleOrdenAsistente(
        id: json["id"]==null?null:int.parse(json["id"].toString()),
        numeroPedido: json["numero_pedido"],
        estado: json["estado"],
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
        aliadoId:json["aliado_id"]==null?null:int.parse( json["aliado_id"].toString()),
        direccionId:json["direccion_id"]==null?null:int.parse( json["direccion_id"].toString()),
        sucursalId:json["sucursal_id"]==null?null:int.parse( json["sucursal_id"].toString()),
        clienteId:json["cliente_id"]==null?null: int.parse(json["cliente_id"].toString()),
        repartidorId: json["repartidor_id"],
        direccion: Direccion.fromJson(json["direccion"]),
        sucursal: Sucursal.fromJson(json["sucursal"]),
        cliente: Cliente.fromJson(json["cliente"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "numero_pedido": numeroPedido,
        "estado": estado,
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
        "direccion": direccion.toJson(),
        "sucursal": sucursal.toJson(),
        "cliente": cliente.toJson(),
    };
}

class Cliente {
    Cliente({
        this.id,
        this.nombre,
        this.numeroDocumento,
        this.telefono,
        this.urlFotoPerfil,
        this.email,
        this.deletedAt,
        this.placaVehiculo,
        this.fotoDocumentoIdentidad1,
        this.fotoDocumentoIdentidad2,
        this.fotoTargetaPropiedad1,
        this.fotoTargetaPropiedad2,
        this.fotoSoat1,
        this.fotoSoat2,
        this.fotoVehiculo1,
        this.fotoVehiculo2,
        this.rol,
        this.tipoVehiculoId,
        this.tipoDocumentoId,
        this.rolId,
        this.idAliado,
        this.idSucursal,
        this.createdAt,
        this.updatedAt,
        this.fcmToken,
    });

    int id;
    String nombre;
    int numeroDocumento;
    int telefono;
    String urlFotoPerfil;
    String email;
    dynamic deletedAt;
    dynamic placaVehiculo;
    dynamic fotoDocumentoIdentidad1;
    dynamic fotoDocumentoIdentidad2;
    dynamic fotoTargetaPropiedad1;
    dynamic fotoTargetaPropiedad2;
    dynamic fotoSoat1;
    dynamic fotoSoat2;
    dynamic fotoVehiculo1;
    dynamic fotoVehiculo2;
    String rol;
    dynamic tipoVehiculoId;
    String tipoDocumentoId;
    dynamic rolId;
    dynamic idAliado;
    dynamic idSucursal;
    DateTime createdAt;
    DateTime updatedAt;
    String fcmToken;

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id:json["id"]==null? null:int.parse(json["id"].toString()),
        nombre: json["nombre"],
        numeroDocumento:json["numero_documento"]==null?null:int.parse( json["numero_documento"].toString()),
        telefono:json["telefono"]==null?null: int.parse(json["telefono"].toString()),
        urlFotoPerfil: json["url_foto_perfil"],
        email: json["email"],
        deletedAt: json["deleted_at"],
        placaVehiculo: json["placa_vehiculo"],
        fotoDocumentoIdentidad1: json["foto_documento_identidad_1"],
        fotoDocumentoIdentidad2: json["foto_documento_identidad_2"],
        fotoTargetaPropiedad1: json["foto_targeta_propiedad_1"],
        fotoTargetaPropiedad2: json["foto_targeta_propiedad_2"],
        fotoSoat1: json["foto_soat_1"],
        fotoSoat2: json["foto_soat_2"],
        fotoVehiculo1: json["foto_vehiculo_1"],
        fotoVehiculo2: json["foto_vehiculo_2"],
        rol: json["rol"],
        tipoVehiculoId: json["tipo_vehiculo_id"],
        tipoDocumentoId: json["tipo_documento_id"],
        rolId:json["rol_id"]==null?null:int.parse( json["rol_id"].toString()),
        idAliado:json["id_aliado"]==null?null:int.parse( json["id_aliado"].toString()),
        idSucursal: json["id_sucursal"]==null?null:int.parse( json["id_sucursal"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fcmToken: json["fcm_token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "numero_documento": numeroDocumento,
        "telefono": telefono,
        "url_foto_perfil": urlFotoPerfil,
        "email": email,
        "deleted_at": deletedAt,
        "placa_vehiculo": placaVehiculo,
        "foto_documento_identidad_1": fotoDocumentoIdentidad1,
        "foto_documento_identidad_2": fotoDocumentoIdentidad2,
        "foto_targeta_propiedad_1": fotoTargetaPropiedad1,
        "foto_targeta_propiedad_2": fotoTargetaPropiedad2,
        "foto_soat_1": fotoSoat1,
        "foto_soat_2": fotoSoat2,
        "foto_vehiculo_1": fotoVehiculo1,
        "foto_vehiculo_2": fotoVehiculo2,
        "rol": rol,
        "tipo_vehiculo_id": tipoVehiculoId,
        "tipo_documento_id": tipoDocumentoId,
        "rol_id": rolId,
        "id_aliado": idAliado,
        "id_sucursal": idSucursal,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "fcm_token": fcmToken,
    };
}

class Direccion {
    Direccion({
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

    factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        id: json["id"]==null?null:int.parse(json["id"].toString()),
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude: json["latitude"] == null
            ? null
            : double.parse(json["latitude"].toString()),
        longitude: json["longitude"] == null
            ? null
            : double.parse(json["longitude"].toString()),
        referencia: json["referencia"],
        tipoDirecionId: json["tipo_direcion_id"],
        deletedAt: json["deleted_at"],
        usuarioId:json["usuario_id"]==null? null:int.parse(json["usuario_id"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
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

class Sucursal {
    Sucursal({
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

    factory Sucursal.fromJson(Map<String, dynamic> json) => Sucursal(
        id: json["id"]==null?null:int.parse(json["id"].toString()),
        nombre: json["nombre"],
        direccion: json["direccion"],
      latitude: json["latitude"] == null
            ? null
            : double.parse(json["latitude"].toString()),
        longitude: json["longitude"] == null
            ? null
            : double.parse(json["longitude"].toString()),
        estado: json["estado"],
        urlFotoPerfil: json["url_foto_perfil"],
        urlFotoPortada: json["url_foto_portada"],
        telefono:json["telefono"]==null?null: int.parse(json["telefono"].toString()),
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
