import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/models/usuario.dart';

class UsuariosService {

  Future<List<Usuario>> getUsuarios() async{
    final token = await AuthService.getToken();

    try {
    final resp = await http.get(
      Uri.parse('${Enviroment.apiUrl}/usuarios'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token!
      },
        );
    final usuariosResponse = usuariosResponseFromJson(resp.body);
    return usuariosResponse.usuario;
    } catch (e) {
      return [];
    }

  }

}