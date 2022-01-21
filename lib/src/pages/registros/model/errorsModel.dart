// To parse this JSON data, do
//
//     final errorsFormModel = errorsFormModelFromJson(jsonString);

import 'dart:convert';

ErrorsFormModel errorsFormModelFromJson(String str) => ErrorsFormModel.fromJson(json.decode(str));

String errorsFormModelToJson(ErrorsFormModel data) => json.encode(data.toJson());

class ErrorsFormModel {
    ErrorsFormModel({
        this.message,
        this.errors,
    });

    String message;
    Map<String, List<String>> errors;

    factory ErrorsFormModel.fromJson(Map<String, dynamic> json) => ErrorsFormModel(
        message: json["message"],
        errors: Map.from(json["errors"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "errors": Map.from(errors).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    };
}
