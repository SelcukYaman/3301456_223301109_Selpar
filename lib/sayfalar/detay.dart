import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/satirbilgileri.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/teklifgoruntule.dart';
import 'package:google_fonts/google_fonts.dart';

import '../sabitler/renk.dart';
import 'Anasayfa.dart';

class Detay extends StatefulWidget {

  const Detay({Key? key}) : super(key: key);

  @override
  State<Detay> createState() => _DetayState();
}

class _DetayState extends State<Detay> {

String isveren="";
  TextEditingController  TeklifSure= TextEditingController();
  TextEditingController  TeklifUcret= TextEditingController();
  TextEditingController  Mesaj= TextEditingController();
  String OnRenk="FFFFFF";String ArkaRenk="2E8B57";
  @override
  Widget build(BuildContext context) {
    final List<String>? message = ModalRoute.of(context)?.settings.arguments as List<String>?;
  late List<String> selcuk=["Başlık:", "Konu:", "Fiyat:", "İşin Yayın Tarihi:"];

    List<Widget> satirListesi = [];

    for(int i=0;i<message!.length-1;i++){
      satirListesi.add(SatirBilgileri(selcuk[i].toString(), message![i]));
    }
    isveren=message[4];
    return Scaffold(
      backgroundColor: Renk_Belirle("D5EEBB"),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(message![0],style: GoogleFonts.abhayaLibre(fontWeight: FontWeight.bold),),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25,bottom: 25),
                  height: 400,
                  decoration: BoxDecoration(
                    color:Renk_Belirle("5F7A61"),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Renk_Belirle("5F7A61"),
                        offset: Offset(0,7),
                        blurRadius: 10,
                      )
                    ]

                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: satirListesi,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25,bottom: 25),
                  height: 400,
                  decoration: BoxDecoration(
                      color:Renk_Belirle("5F7A61"),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Renk_Belirle("5F7A61"),
                          offset: Offset(0,7),
                          blurRadius: 10,
                        )
                      ]

                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BaslikBilgileri("Teklif Miktarı"),TeklifMiktari(TeklifUcret),
                            ],
                          ),
                        ),  Container(
                  margin: EdgeInsets.only(top: 15),child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BaslikBilgileri("Yapım Süresi"),TeklifMiktari(TeklifSure),
                          ],
                        ), ),  Container(
                  margin: EdgeInsets.only(top: 15), child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BaslikBilgileri("Belirtmek istediğiniz mesaj"),TeklifMiktari(Mesaj),
                            ],
                        ),
                        ),

                        TeklifVer(message![0])
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  final snackBar = SnackBar(
    content: Text('Lütfen Tüm Alanları Doldurunuz'),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.red,

  );
  Widget TeklifVer(String baslik){
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Renk_Belirle(ArkaRenk)

      ),
      child: FilledButton(onPressed: (){
        if(TeklifSure.text!=""&&TeklifUcret.text!=""&&Mesaj.text!=""&&TeklifSure.text!=null&&TeklifUcret.text!=null&&Mesaj.text!=null){
          List<String> data = [];
          print(TeklifUcret.text+" "+TeklifSure.text+" "+Mesaj.text+" ");
          data.add(baslik);
          data.add(TeklifUcret.text);
          data.add(TeklifSure.text);
          data.add(Mesaj.text);
          data.add(isveren);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeklifGoruntule(),
              settings: RouteSettings(
                arguments: data, // aktarılacak veri
              ),
            ),
          );
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
        style: FilledButton.styleFrom(backgroundColor: Renk_Belirle(ArkaRenk)),
        child: Text("Teklif Ver",style: GoogleFonts.quicksand(fontSize: 25),),),
    );
  }
  Widget TeklifMiktari(TextEditingController deneme){
    return  Container(

    width: 200,
    height: 60,

    decoration:BoxDecoration(

    borderRadius: BorderRadius.only(

    topRight: Radius.circular(12),

    bottomRight: Radius.circular(12),



    ),color: Renk_Belirle(OnRenk),

    ) ,

    padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),

    child: TextField(
    decoration: InputDecoration(
    border: InputBorder.none,
    filled: true,
    fillColor: Renk_Belirle("ffffff"),
  ),
  style: TextStyle(color: Renk_Belirle("2E8B57")),
  controller: deneme,
  ),



  );
}
  Widget get girisbutton => Center(
    child: Container(
      height: 44,
      width: 200,

      child: FilledButton(onPressed: () {


          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Anasayfa(),
              settings: RouteSettings(
                arguments: 20, // aktarılacak veri
              ), ),
          );
      },child:Text("Giriş",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'Source Sans Pro'),),),

    ),
  );
}
