// To parse this JSON data, do
//
//     final usuariosResponse = usuariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

UsuariosResponse usuariosResponseFromJson(String str) => UsuariosResponse.fromJson(json.decode(str));

String usuariosResponseToJson(UsuariosResponse data) => json.encode(data.toJson());

class UsuariosResponse {
  bool ok;
  List<Usuario> usuario;

  UsuariosResponse({
    required this.ok,
    required this.usuario,
  });

  factory UsuariosResponse.fromJson(Map<String, dynamic> json) => UsuariosResponse(
  ok: json["ok"],
  usuario: List<Usuario>.from(json["usuario"].map((x) => Usuario.fromJson(x))), // singular ✅
  );

  Map<String, dynamic> toJson() => {
  "ok": ok,
  "usuario": List<dynamic>.from(usuario.map((x) => x.toJson())), // singular ✅
  };
}
