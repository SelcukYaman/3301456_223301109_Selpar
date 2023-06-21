import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/renk.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../sayfalar/isguncelle.dart';
import '../sayfalar/detay.dart';
import 'islemler.dart';
Widget YatayTaslak(String baslik,String aciklama,String fiyat, String tarih,BuildContext context1,String IsSahibi){
  String truncatedAciklama ;
  if (aciklama.length > 23) {
    truncatedAciklama = aciklama.substring(0, 23) + "...";
  } else{  truncatedAciklama=aciklama;}

    return Container(

        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 10),

        decoration: BoxDecoration(
          color: Renk_Belirle("00E7FF"),
          border: Border.all(color: Renk_Belirle("000000"), width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(children: [ Container(
          width: 85,
          height: 75,
          child: AutoSizeText(baslik,
            style: GoogleFonts.babylonica(color: Colors.white, fontSize: 16),),
          decoration: BoxDecoration(color: Renk_Belirle("123456"),
              borderRadius: BorderRadius.circular(150)),
          padding: EdgeInsets.all(25),

        ),
          SizedBox(width: 10,),
          Column(children: [
            AutoSizeText(truncatedAciklama,
              style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),),
            Row(children: [
              AutoSizeText(fiyat,
                style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
              SizedBox(width: 30,),
              AutoSizeText(tarih,
                style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
            ],)

          ],),
          Column(children: [
            IconButton(
              icon: Icon(Icons.shop),
              onPressed: () {
                List<String> data=[];
                data.clear();
                data.add(baslik);
                data.add(aciklama);
                data.add(fiyat);
                data.add(tarih);
                data.add(IsSahibi);
                Navigator.push(
                  context1!,
                  MaterialPageRoute(builder: (context1) => Detay(),
                    settings: RouteSettings(
                      arguments:data , // aktarılacak veri
                    ),  ),
                );
              },)
          ],)
        ],
        )
    );
  }

Widget DikeyTaslak(String baslik,String path,String aciklama,String fiyat, String tarih,BuildContext context1,String IsSahibi){
print(path+"burası path");
  if(baslik!=null&&aciklama!=null&&fiyat!=null&&tarih!=null){

    String truncatedAciklama ;
    if (aciklama.length > 23) {
       truncatedAciklama = aciklama.substring(0, 23) + "...";
    } else{  truncatedAciklama=aciklama;}
  return Container(

      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(

        border: Border.all(color: Renk_Belirle("000000"),width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(children:[
        Container(
          width: 85,
          height: 75,
          decoration: BoxDecoration(
            color: Renk_Belirle("123456"),
            borderRadius: BorderRadius.circular(150),
          ),
          padding: EdgeInsets.all(25),
          child:
            Image.network(
              path,
          ),
        ),
    SizedBox(width: 10,),
        Column(children: [
          AutoSizeText(truncatedAciklama ,style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),),
          Row(children: [
            AutoSizeText(fiyat,style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
            SizedBox(width: 30,),
            AutoSizeText(tarih,style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
          ],)

        ],),
        Column(children: [
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              List<String> data=[];
              data.clear();
              data.add(baslik);
              data.add(aciklama);
              data.add(fiyat);
              data.add(tarih);
              data.add(IsSahibi);
              if(context1!=null){   Navigator.push(
                context1!,

                MaterialPageRoute(builder: (context1) => Detay(),
                  settings: RouteSettings(
                    arguments:data , // aktarılacak veri
                  ),  ),
              );
            }})
        ],)
      ],
      )
  );
}
else {return Container(

  );}}
Widget ProfilTaslak(String baslik,String aciklama,String fiyat, String tarih,BuildContext context1,String id){

  if(baslik!=null&&aciklama!=null&&fiyat!=null&&tarih!=null){

    String truncatedAciklama ;
    if (aciklama.length > 23) {
       truncatedAciklama = aciklama.substring(0, 23) + "...";
    } else{  truncatedAciklama=aciklama;}
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context1,
        MaterialPageRoute(
          builder: (context1) => TeklifGuncelle(ilanId: id),
        ),
      );
    },
    child:Container(

      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(

        border: Border.all(color: Renk_Belirle("000000"),width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(children:[ Container(
        width:85,height: 75,
        child: AutoSizeText(baslik,style: GoogleFonts.babylonica(color: Colors.white,fontSize: 16),),
        decoration: BoxDecoration(color: Renk_Belirle("123456"),borderRadius: BorderRadius.circular(150)),
        padding: EdgeInsets.all(25),

      ),
        SizedBox(width: 10,),

        Column(children: [
          AutoSizeText(truncatedAciklama ,style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),),
          Row(children: [
            AutoSizeText(fiyat,style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
            SizedBox(width: 30,),
            AutoSizeText(tarih,style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
          ],),


        ],),

        Row(children: [
          IconButton(

            icon: Icon(Icons.delete,),
            onPressed: () {
              deleteData(id,context1);
            },),
        ],)
      ],
      ),),
  );
}
else {return Container(

  );}}

Widget TeklifTema(BuildContext context,String yazi){
  return  Container(
    height: MediaQuery.of(context).size.height/4,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.all(25),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Renk_Belirle("D7FBE8"),

      boxShadow: [
        BoxShadow(
          color: Renk_Belirle("D7FBE8"),
          offset: Offset(0,7),
          blurRadius: 10,
        )
      ],
    ),
    child: AutoSizeText(yazi.toString(),style: GoogleFonts.quicksand(color: Colors.black,decoration: TextDecoration.none),),
  );
}
Widget BaslikBilgileri(String Baslik,{String OnRenk:"FFFFFF",String ArkaRenk:"444941"}){
  return Container(

    width: 150,
    height: 60,
    decoration:BoxDecoration(

      borderRadius: BorderRadius.only(

        topLeft: Radius.circular(12),

        bottomLeft: Radius.circular(12),



      ),color: Renk_Belirle(ArkaRenk),

    ) ,

    padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),

    child: AutoSizeText(Baslik,style: GoogleFonts.quicksand(color: Renk_Belirle(OnRenk),fontSize: 17,fontWeight: FontWeight.bold),
      maxLines: 2,
    ),



  );
}
Widget SatirBilgileri(String Baslik,String icerik,{String OnRenk:"FFFFFF",String ArkaRenk:"444941"}){
return Container(

  margin: EdgeInsets.symmetric(vertical: 10),
  child:   Container(

    child: Row(

mainAxisAlignment: MainAxisAlignment.center,
    children: [

    Container(

width: 150,
      height: 60,
    decoration:BoxDecoration(

      borderRadius: BorderRadius.only(

        topLeft: Radius.circular(12),

        bottomLeft: Radius.circular(12),



      ),color: Renk_Belirle(ArkaRenk),

     ) ,

      padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),

    child: AutoSizeText(Baslik,style: GoogleFonts.quicksand(color: Renk_Belirle(OnRenk),fontSize: 17,fontWeight: FontWeight.bold),
      maxLines: 2,
    ),



    ),

      Container(

width: 200,
height: 60,

        decoration:BoxDecoration(

          borderRadius: BorderRadius.only(

            topRight: Radius.circular(12),

            bottomRight: Radius.circular(12),



          ),color: Renk_Belirle(OnRenk),

        ) ,

        padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),

        child: AutoSizeText(icerik,style: GoogleFonts.quicksand(color: Renk_Belirle(ArkaRenk),fontSize: 15,fontWeight: FontWeight.bold),
maxLines: 2,
        ),



      )

    ],

    ),
  ),
);

}