
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'deneme2.dart';

class Deneme1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigator Hatası',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Anasayfa'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('İkinci Sayfaya Git'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Deneme2()),
              );
            },
          ),
        ),
      ),
    );
  }
}