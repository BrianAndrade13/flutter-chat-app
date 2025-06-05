import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier {

    late Usuario usuarioPara;

    Future<List<Mensaje>> getChat(String usuarioId) async {
      final uri = Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioId');

      final token = await AuthService.getToken(); // Asegúrate de importar AuthService

      final resp = await http.get(  // <-- CAMBIAR A GET
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token ?? ''     // Asegúrate de enviar el token si es necesario
        }
      );

      if (resp.statusCode == 200) {
        final mensajesResp = mensajesResponseFromJson(resp.body);
        return mensajesResp.mensajes;
      } else {
        return [];
      }
}

}