// To parse this JSON data, do
//
//     final respLoginModel = respLoginModelFromJson(jsonString);

import 'dart:convert';

RespLoginModel respLoginModelFromJson(String str) => RespLoginModel.fromJson(json.decode(str));

String respLoginModelToJson(RespLoginModel data) => json.encode(data.toJson());

class RespLoginModel {
    RespLoginModel({
        this.tokenType,
        this.expiresIn,
        this.accessToken,
        this.refreshToken,
    });

    String tokenType;
    int expiresIn;
    String accessToken;
    String refreshToken;

    factory RespLoginModel.fromJson(Map<String, dynamic> json) => RespLoginModel(
        tokenType: json["token_type"],
        expiresIn: int.parse(json["expires_in"].toString()),
        accessToken: json["access_token"].toString(),
        refreshToken: json["refresh_token"],
    );

    Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
        "refresh_token": refreshToken,
    };
}
