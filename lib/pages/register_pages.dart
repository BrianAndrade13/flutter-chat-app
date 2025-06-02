import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class RegisterPages extends StatelessWidget {
  const RegisterPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(text: 'Registrarse',),
            
                _Form(),
            
                Labels(ruta: 'login', text1: '¿Ya Tienes Cuenta?', text2: 'Entonces Inicia Sesion'),
            
                Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w600),)
              ],
            ),
          ),
        ),
      )
    );
  }
}


  

  class _Form extends StatefulWidget {
    const _Form();
  
    @override
    State<_Form> createState() => __FormState();
  }
  
  class __FormState extends State<_Form> {

    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

    @override
    Widget build(BuildContext context) {

      final authServices = Provider.of<AuthService>(context);

      return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [

          CustomInput(
          icon: Icons.perm_identity, 
          placeholder: 'Nombre', 
          textController: nameCtrl,
          keyboardType: TextInputType.text
          ),    

          CustomInput(
          icon: Icons.email, 
          placeholder: 'Correo', 
          textController: emailCtrl,
          keyboardType: TextInputType.emailAddress
          ),
          
          CustomInput(
          icon: Icons.lock_outline, 
          placeholder: 'Contraseña', 
          textController: passwordCtrl,
          isPassword: true,
          ),
  
            authServices.autenticando
            ? BotonAzul(text: 'Crear Cuenta', onPressed:null)
            : BotonAzul(text: 'Crear Cuenta', onPressed: () async{
              final registerOk = await authServices.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passwordCtrl.text.trim());
              
              if(registerOk == true){
                //TODO: Conectar al Socket Server
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Usuario Ya Registrado', 'El Usuario ya esta Registrad', Colors.white);
              }
              }, background: Colors.blue)
          ],
        ),
      );
    }
  }

 