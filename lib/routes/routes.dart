import 'package:flutter/material.dart';

import '../pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios':  ( _ ) => UsuariosPages(),
  'chat': ( _ ) => ChatPages(),
  'login': ( _ ) => LoginPages(),
  'loading': ( _ ) => LoadingPages(),
  'register': ( _ ) => RegisterPages(),

};