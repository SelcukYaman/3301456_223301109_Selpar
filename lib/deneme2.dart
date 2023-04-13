
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deneme2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İkinci Sayfa'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Anasayfaya Geri Dön'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}