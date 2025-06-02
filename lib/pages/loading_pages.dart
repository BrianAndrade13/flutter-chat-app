import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

@override
void initState() {
  super.initState();

  _fadeController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );

  _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
  );

  _fadeController.forward();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    checkLoginState(context);
  });
}


  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: FutureBuilder(
      future: checkLoginState(context), 
      builder: (context, snapshot) {
        return FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Image.asset(
                'assets/tag-logo.png',
                width: 130,
                height: 130,
              ),
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  "Made In",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 10),
                Image.asset(
                  'assets/logo.png', 
                  width: 90,
                  height: 90,
                ),
                SizedBox(height: 20),
                ],
              )
            ],
          ),
        );
       }, 
     ),
   );
  }

 Future checkLoginState(BuildContext context) async {
  final authService = Provider.of<AuthService>(context, listen: false);
  final autenticado = await authService.isLoggedIn();

  await Future.delayed(Duration(milliseconds: 1500));

  if (autenticado) {
    Navigator.pushReplacementNamed(context, 'usuarios');
  } else {
    Navigator.pushReplacementNamed(context, 'login');
  }
 }
}

//! Codigo Simple
// import 'package:chat_app/pages/pages.dart';
// import 'package:chat_app/services/auth_services.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class LoadingPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: checkLoginState(context),
//         builder: ( context, snapshot) {
//           return Center(
//                 child: Text('Espere...'),
//           );
//         },
        
//       ),
//    );
//   }

//   Future checkLoginState( BuildContext context ) async {

//     final authService = Provider.of<AuthService>(context, listen: false);

//     final autenticado = await authService.isLoggedIn();

//     if ( autenticado ) {
//       // TODO: conectar al socket server
//       // Navigator.pushReplacementNamed(context, 'usuarios');
//       Navigator.pushReplacement(
//         context, 
//         PageRouteBuilder(
//           pageBuilder: ( _, __, ___ ) => UsuariosPages(),
//           transitionDuration: Duration(milliseconds: 0)
//         )
//       );
//     } else {
//       Navigator.pushReplacement(
//         context, 
//         PageRouteBuilder(
//           pageBuilder: ( _, __, ___ ) => LoginPages(),
//           transitionDuration: Duration(milliseconds: 0)
//         )
//       );
//     }

//   }

// }