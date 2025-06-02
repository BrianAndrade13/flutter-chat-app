
import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

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
                Logo(text: 'Messenger',),
            
                _Form(),
            
                Labels(ruta: 'register', text1: '¿No Tienes Cuenta?', text2: 'Entonces Crea Una!!'),
            
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

    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

    @override
    Widget build(BuildContext context) {


      final authService = Provider.of<AuthService>(context);

      return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [

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
  
            authService.autenticando
            ? BotonAzul(text: 'Ingrese', onPressed:null)
            : BotonAzul(
                text: 'Ingrese',
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final loginOk = await authService.login(
                    emailCtrl.text.trim(),
                    passwordCtrl.text.trim(),
                  );

                  if(loginOk){
                    //TODO: Conectar a nuestro Socket Server
                    Navigator.pushReplacementNamed(context, 'usuarios');
                  } else {
                    //Mostrar alerta
                    mostrarAlerta(context, 'Login No Encontrado', 'Revise sus credenciales Nuevamente', Colors.white);
                  }
                }, 
                background: Colors.blue,
              ),
          ],
        ),
      );
    }
  }

 