import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/renk.dart';

import '../arayuz.dart';

class IlanVer extends StatefulWidget {
  const IlanVer({Key? key}) : super(key: key);

  @override
  State<IlanVer> createState() => _IlanVerState();
}

class _IlanVerState extends State<IlanVer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      backgroundColor: Renk_Belirle("3AFCEF"),
      body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                TextButton(onPressed: (){  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Arayuz(),
                  ),
                );},child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon( Icons.home,color: Renk_Belirle("009EFF"),),
                    Text("Ana Sayfa",style: TextStyle(color: Renk_Belirle("009EFF")),),


                  ],
                )
                ),

              ],),

        Expanded(
          child: Container(
height: MediaQuery.of(context).size.height-84,
                decoration: BoxDecoration(
                    border: Border.all(color: Renk_Belirle("3AFCEF"),width: 15,)
                ),
                child: Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Renk_Belirle(renk),
                        border: Border.all(color: Renk_Belirle(renk),width: 15,)
                    ),
                    child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [

                      Konu("İşin Konusu",50),
                      Konu("İşin Fiyat",50),
                      Konu("İşin Açıklaması",100),

                    ],
                    ),
                  ),
                ),
              ),
        ),

          ]
      ),
    ),
    );
  }
  Widget Konu(String Baslik ,double Yukseklik){
    return Container(
margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
      Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width/3,
      height: Yukseklik,
      decoration: BoxDecoration(
        border: Border.all(color: Renk_Belirle("32D9C9"),width: 15,),
        color: Renk_Belirle("32D9C9"),
      ),
        child: AutoSizeText(Baslik,style: GoogleFonts.quicksand()),
      ) ,
        Container(
      width: MediaQuery.of(context).size.width/2,
          height: Yukseklik,
      decoration: BoxDecoration(
        border: Border.all(color: Renk_Belirle("43F0DC"),width: 15,),
        color: Renk_Belirle("43F0DC"),
      ),
        child: SizedBox(
          height: 18,

            child: Container(
              child: TextFormField(
                maxLines: null, // Çok satırlı giriş sağlar.
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                // Metin değiştiğinde tetiklenecek fonksiyon
                onChanged: (value) {
                  // Değişiklikleri işleyin.
                },
              )
            ),

        ),
        )
      ],),
    );
  }
}
