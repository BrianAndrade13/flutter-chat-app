import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}
class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket? get socket => _socket;
  Function(String, dynamic)? get emit => _socket?.emit;

  void connect() async {
    final token = await AuthService.getToken();

    // Si ya había un socket conectado, lo cerramos
    _socket?.disconnect();

    _socket = IO.io(Enviroment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
    });

    _socket?.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket?.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket?.disconnect();
  }
}
