import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPages extends StatefulWidget {
  const ChatPages({super.key});

  @override
  State<ChatPages> createState() => _ChatPagesState();
}

class _ChatPagesState extends State<ChatPages> with TickerProviderStateMixin {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  final List<ChatMessage> _message = [
  ];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 12, color: Colors.white)),
              backgroundColor: Colors.blue,
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text('Tenorio', style: TextStyle(color: Colors.black87, fontSize: 20))
          ],
        ),
          centerTitle: true,
          elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _message.length,
                itemBuilder: (_, i) => _message[i],
                reverse: true,
              )),

              Divider(height: 1),

              //TODO: caja de texto
              Container(
                color: Colors.white,
                child: _inputChat(),
              ),

          ],
        ),
      )
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                cursorColor: Colors.blue,
                controller: _textController,
                onSubmitted: _handlerSubmit,
                onChanged: (String texto) {
                  setState(() {
                    if(texto.trim().length > 0 ) {
                      _estaEscribiendo = true; 
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar Mensaje',
                ),
                focusNode: _focusNode,
              )),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Platform.isIOS
                ? CupertinoButton(
                  child: Text('Enviar'), 
                  onPressed: _estaEscribiendo
                      ? () => _handlerSubmit(_textController.text.trim())
                      : null,
                  )
                : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton( 
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.send),
                      onPressed: _estaEscribiendo
                      ? () => _handlerSubmit(_textController.text.trim())
                      : null,
                      ),
                  ),
                ) 
              )
          ],
        ),
    ));
  }

  _handlerSubmit(String texto) {
    
    if(texto.length == 0) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(uid: '123', texto: texto, animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 400)));
    _message.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: Off del Socket
    for(ChatMessage message in _message) {
      message.animationController.dispose();
    }

    super.dispose();
  }

}