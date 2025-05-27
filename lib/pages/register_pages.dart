import 'package:flutter/material.dart';

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
    const _Form({super.key});
  
    @override
    State<_Form> createState() => __FormState();
  }
  
  class __FormState extends State<_Form> {

    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

    @override
    Widget build(BuildContext context) {
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
  
            BotonAzul(text: 'Ingrese', onPressed: () {
              print(emailCtrl.text);
              print(passwordCtrl.text);
              },)
          ],
        ),
      );
    }
  }

 