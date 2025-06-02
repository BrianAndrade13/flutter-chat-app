import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuariosPages extends StatefulWidget {
  const UsuariosPages({super.key});

  @override
  State<UsuariosPages> createState() => _UsuariosPagesState();
}

class _UsuariosPagesState extends State<UsuariosPages> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(online: true, correo: 'test1@gmail.com', nombre: 'Brian', uid: '1'),
    Usuario(online: false, correo: 'test2@gmail.com', nombre: 'Enric', uid: '2'),
    Usuario(online: true, correo: 'test3@gmail.com', nombre: 'Andrade', uid: '3')
  ];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(221, 20, 23, 221),
        title: Text(usuario!.nombre, style: TextStyle(color: Colors.white),),
        elevation: 1,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          //TODO: Desconectar el Socket Server
          Navigator.pushReplacementNamed(context, 'login');
          AuthService.deleteToken();
        }, 
        icon: Icon(Icons.exit_to_app, color: Colors.white)),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          // child: Icon(Icons.check_circle, color: Colors.green),
          child: Icon(Icons.offline_bolt, color: Colors.red),
        )
      ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue),
          waterDropColor: Colors.blue,
        ),
        child: _listViewUsuarios(),
        )
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, i) => Divider(), 
      itemCount: usuarios.length,
      itemBuilder: (_, i) => _usuariosListTile(usuarios[i]), 
      );
  }

  ListTile _usuariosListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.correo),
        leading: CircleAvatar(
          backgroundColor: Color.fromARGB(221, 20, 23, 221),
          child: Text(usuario.nombre.substring(0,2), style: TextStyle(color: Colors.white)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)
           ),
        ),
      );
  }

  _cargarUsuarios() async {
       // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}