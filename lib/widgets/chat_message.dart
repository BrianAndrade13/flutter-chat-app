import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  
  final String uid;
  final String texto;
  final AnimationController animationController;

  const ChatMessage({super.key, required this.uid, required this.texto, required this.animationController});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: this.uid == authService.usuario!.uid
          ? _myMessage()
          : _notMyMessage(),
        ),
      ),
    );
  }

  
 _myMessage() {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
        right: 5,
        bottom: 5,
        left: 50
      ),
      child: Text(this.texto, style: TextStyle(color: Colors.white)),
      decoration: BoxDecoration(
        color: Color(0xff4D9EF6),
        borderRadius: BorderRadius.circular(20)
      ),
    ));
 }


 _notMyMessage() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
        left: 5,
        bottom: 5,
        right: 50
      ),
      child: Text(this.texto, style: TextStyle(color: Colors.black87)),
      decoration: BoxDecoration(
        color: Color(0xffE4E5E8),
        borderRadius: BorderRadius.circular(20)
      ),
    ));
 }
}
