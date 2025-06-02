import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo, Color background) {

      if(Platform.isAndroid) {
        return showDialog(
        context: context, 
        builder: ( _ ) => AlertDialog(
          backgroundColor: background,
          title: Text(titulo),
          content: Text(subtitulo),
          actions: [
            MaterialButton(
              child: Text('Okay'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
              }),
          ],
        ), 
      );
    } 

    return showCupertinoDialog(
      context: context, 
      builder: ( _ ) => CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          CupertinoDialogAction(
            child: Text('Okay'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ));

}