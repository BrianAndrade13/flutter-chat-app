import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/login_response.dart';
import '../models/usuario.dart';

class AuthService with ChangeNotifier {

  Usuario? usuario;
  bool _autenticando = false;
  
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando( bool valor ) {
    this._autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }


  Future<bool> login( String correo, String contrasena ) async {
    
    this.autenticando = true;

    final data = {
      'correo': correo,
      'contraseña': contrasena
    };

    final uri = Uri.parse('${ Enviroment.apiUrl }/login');
    final resp = await http.post(uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String correo, String contrasena ) async {

    this.autenticando = true;

    final data = {
      'nombre': nombre,
      'correo': correo,
      'contraseña': contrasena
    };

    final uri = Uri.parse('${ Enviroment.apiUrl }/login/new');
    final resp = await http.post(uri, 
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );

    this.autenticando = false;

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

// Future<bool> isLoggedIn() async {
//   try {
//     final token = await _storage.read(key: 'token');
//     print('Token actual: $token');

//     if (token == null) return false;

//     final resp = await http.get(
//       Uri.parse('${Enviroment.apiUrl}/login/renew'),
//       headers: {
//         'Content-Type': 'application/json',
//         'x-token': token
//       },
//     );

//     print('Renovar token status: ${resp.statusCode}');
//     print('Renovar token body: ${resp.body}');

//     if (resp.statusCode == 200 && resp.body.isNotEmpty) {
//       final Map<String, dynamic> decoded = jsonDecode(resp.body);

//       if (decoded['usuario'] == null) {
//         print('Usuario es null, token inválido o inconsistente');
//         await logout();
//         return false;
//       }

//       final loginResponse = loginResponseFromJson(resp.body);
//       this.usuario = loginResponse.usuario;
//       await _guardarToken(loginResponse.token);
//       return true;
//     } else {
//       await logout();
//       return false;
//     }
//   } catch (e) {
//     print('Error en isLoggedIn: $e');
//     return false;
//   }
// }

Future<bool> isLoggedIn() async {
  try {
    final token = await _storage.read(key: 'token');
    if (token == null) return false;

    final resp = await http.get(
      Uri.parse('${Enviroment.apiUrl}/login/renew'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      },
    );


    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      await logout();
      return false;
    }
  } catch (e) {
    await logout();
    return false;
  }
}




  Future _guardarToken( String token ) async {
    return await _storage.write(key: 'token', value: token );
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

}