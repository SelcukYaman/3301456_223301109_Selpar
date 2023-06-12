import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/renk.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/satirbilgileri.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/Anasayfa.dart';
import 'package:google_fonts/google_fonts.dart';

class IsGuncelle extends StatefulWidget {
  const IsGuncelle({Key? key}) : super(key: key);

  @override
  State<IsGuncelle> createState() => _TeklifGoruntuleState();
}

class _TeklifGoruntuleState extends State<IsGuncelle> {
  User? _user;
  String isinadi="";
  String isingunu="";
  String isinfiyati="";
  String isinaciklamasi="";
  String isveren="";
  String teklifiveren="";
  Future<void> _fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      setState(() {
        _user = currentUser;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    _fetchUserData();
    final List<String>? message = ModalRoute.of(context)?.settings.arguments as List<String>?;
    double ucret=double.parse(message![1]);
    double gun=double.parse(message![2]);
    double gunluk=ucret/gun;
    String TeklifDetay=message![0]+" işini "+gun.toString()+" gün boyunca, günlük "+ gunluk.toString()+"TL ücret karşılığında toplamda "+ucret.toString()+"TL alarak işi bitirmeyi taahhüt ediyorsunuz.";
   isinadi=message![0];
   isingunu=message![2];
   isinfiyati=message![1];
   isinaciklamasi=message![3];
   isveren=message![4];
    teklifiveren= _user!.email ?? '';
    return Column(
      children: [
        Container(
          color: Renk_Belirle("1FAB89"),
          child: Container(
            height: MediaQuery.of(context).size.height-50,
            width: MediaQuery.of(context).size.width-50,
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Renk_Belirle("9DF3C4"),

              boxShadow: [
              BoxShadow(
                color: Renk_Belirle("9DF3C4"),
                offset: Offset(0,7),
                blurRadius: 10,
              )
            ],
            ),
            child:SingleChildScrollView(
              child: Column(
                children: [
                 TeklifTema(context, "Mesajınız: "+message![3]),

                 TeklifTema(context, TeklifDetay),
                  TeklifVer("Gönder")
                ],
              ),
            ),

          ),

        ),
      ],
    );

  }

  final snackBar = SnackBar(
    content: Text('İşlem Başarılı'),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.red,

  );
  Widget TeklifVer(String baslik){
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Renk_Belirle("62D2A2")

      ),
      child: FilledButton(onPressed: (){
        createCollectionWithAutoID(isinadi,isinfiyati,isinaciklamasi,isingunu,teklifiveren,isveren);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Anasayfa(),

            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);



      },
        style: FilledButton.styleFrom(backgroundColor: Renk_Belirle("62D2A2")),
        child: Text(baslik,style: GoogleFonts.quicksand(fontSize: 25),),),
    );
  }

  void createCollectionWithAutoID(String adi,String fiyati,String aiklama,String gun,String Kullaniciadi,String KayitSahibi) {

    if ((Kullaniciadi==""||Kullaniciadi==null)&&_user!=null){
      Kullaniciadi=_user!.email.toString();
    }
    FirebaseFirestore.instance.collection('selcukyaman321321').add({

      'date': adi,
      'IsAciklama': fiyati,
      'IsAdi': aiklama,
      'IsFiyati': gun,
      'Kullaniciadi': Kullaniciadi,
      'KayitSahibi': KayitSahibi,

    })
        .then((value) {
      print('Tablo oluşturuldu ve veri eklendi. Tablo ID: ${value.id}');
    })
        .catchError((error) {
      print('Hata: $error');
    }); print("dgksjkjg"+adi);
  }



}
