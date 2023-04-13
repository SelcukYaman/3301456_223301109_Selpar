

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selpar_selcuk_yamann_223301109/arayuz.dart';
import 'package:selpar_selcuk_yamann_223301109/main.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/renk.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/satirbilgileri.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/detay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/ilanver.dart';
class Anasayfa extends StatelessWidget {
 late BuildContext? context1;



  @override
  Widget build(BuildContext context) {
    context1=context;
    final String? message = ModalRoute.of(context)?.settings.arguments as String?;
final double ekran=MediaQuery.of(context).size.height;

    return SafeArea(child:
    Scaffold(
      backgroundColor: Renk_Belirle("CFF5E7"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    TextButton(onPressed: (){  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IlanVer(),
                      ),
                    );},child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon( Icons.add,color: Renk_Belirle("009EFF"),),
                        Text("İlan Ver",style: TextStyle(color: Renk_Belirle("009EFF")),),


                      ],
                    )
                    ),

                  ],)
            ],),
           
            Container(
            height: 150,

              child: Container(

                margin: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width-25,


               child: ListView( scrollDirection: Axis.horizontal,children: [
                 YatayTaslak("Yıkım", "70 M2'lik duvar yıkılması", "600TL", "22.04.2023", context),
                 SizedBox(width: 10,),
    YatayTaslak("Boya", "30 M2'lik duvar boyanması", "400TL", "28.04.2023", context),
                  SizedBox(width: 10,),
    YatayTaslak("Tesisat", "Mutfak lavobosu su sızıntısının giderilmesi", "300TL", "17.04.2023", context),
               ]),
                  
               
              ),

          ),
            Expanded(child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Renk_Belirle("A0E4CB"),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),

                ),
                child: Column(

                  children: [
                    Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                  Text("Öne Çıkan İşler.",
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,fontSize: 20),
                  ),

                      Text("Size Özel İşler.",
                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                ],
                    ),
          
                 
                   Container(
                      width: MediaQuery.of(context).size.width-25,
                    child: DikeyTaslak("Tesisat", "Mutfak lavobosu su sızıntısının giderilmesi", "300TL", "17.04.2023", context),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width-25,
                    child:  DikeyTaslak("Örme", "Çocuğum için oyuncak ayı ördürmek istiyorum", "200TL", "22.05.2023", context),
                    ), Container(
                      width: MediaQuery.of(context).size.width-25,
                    child:  DikeyTaslak(
                        "Yıkım", "70 M2'lik duvar yıkılması", "600TL", "22.04.2023", context),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width-25,
                    child:  DikeyTaslak("Mobilya", "Dolaplarımın kapaklarının takılması ve ayarlanamsı gerekiyor", "325TL", "25.04.2023", context),
                    ), Container(
                      width: MediaQuery.of(context).size.width-25,
                    child: DikeyTaslak("Boya", "30 M2'lik duvar boyanması", "400TL", "28.04.2023", context),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width-25,
                    child: BoyaTaslak,
                    ),
                
              



                  ],
                ),
              ),
            ))
          ]
      ),
    ),
    );
  }
  Widget get IconButonsl => Center(
    child: Container( alignment:  Alignment.topLeft,
      height: 44,
      width: 200,
      child: IconButton(
        icon: Icon(Icons.shop),
        onPressed: () {
          // Sepet sayfasına gitmek için buraya yönlendirme kodu eklenebilir
        },
      ),

    ),
  );
 List<String> data = [];
  Widget get ContainerTaslak => Container(

      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(

        border: Border.all(color: Renk_Belirle("000000"),width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(children:[ Container(
        width:85,height: 75,
        child: Text("Yıkım",style: GoogleFonts.babylonica(color: Colors.white,fontSize: 16),),
        decoration: BoxDecoration(color: Renk_Belirle("123456"),borderRadius: BorderRadius.circular(150)),
        padding: EdgeInsets.all(25),

      ),
        SizedBox(width: 10,),
        Column(children: [
          Text("50 Mt2'lik duvar yıkımı",style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),),
          Row(children: [
            Text("475TL",style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
            SizedBox(width: 30,),
            Text("23.05.2023",style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
          ],)

        ],),
        Column(children: [
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              data.clear();
              data.add("Yıkım");
              data.add("50 Mt2'lik duvar yıkımı");
              data.add("475TL");
              data.add("23.05.2023");
              Navigator.push(
                context1!,

                MaterialPageRoute(builder: (context1) => Detay(),
                  settings: RouteSettings(


                    arguments:data , // aktarılacak veri
                  ),
                   ),
              );
            },)
        ],)
      ],
      )
  );
  Widget get BoyaTaslak => Container(

      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(

        border: Border.all(color: Renk_Belirle("000000"),width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(children:[ Container(
        width:85,height: 75,
        child: Text("Boya",style: GoogleFonts.babylonica(color: Colors.white,fontSize: 16),),
        decoration: BoxDecoration(color: Renk_Belirle("123456"),borderRadius: BorderRadius.circular(150)),
        padding: EdgeInsets.all(25),

      ),
        SizedBox(width: 10,),
        Column(children: [
          Text("20 Mt2'lik duvar boyaması",style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),),
          Row(children: [
            Text("500TL",style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
            SizedBox(width: 30,),
            Text("18.04.2023",style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
          ],)

        ],),
        Column(children: [
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              data.clear();
              data.add("Boya");
              data.add("20 Mt2'lik duvar boyaması");
              data.add("500TL");
              data.add("18.04.2023");
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
  Widget get AktifTaslak => Container(

      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(
          color: Colors.indigo,
        border: Border.all(color: Renk_Belirle("000000"),width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(children:[ Container(
        width:85,height: 75,
        child: Text("Boya",style: GoogleFonts.babylonica(color: Colors.white,fontSize: 16),),
        decoration: BoxDecoration(color: Renk_Belirle("123456"),borderRadius: BorderRadius.circular(150)),
        padding: EdgeInsets.all(25),

      ),
        SizedBox(width: 10,),
        Column(children: [
          Text("20 Mt2'lik duvar boyaması",style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),),
          Row(children: [
            Text("500TL",style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
            SizedBox(width: 30,),
            Text("18.04.2023",style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),),
          ],)

        ],),
        Column(children: [
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              data.clear();
              data.add("Boya");
              data.add("20 Mt2'lik duvar boyaması");
              data.add("500TL");
              data.add("18.04.2023");
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

  Widget get yazi => Row(
    children: [Container(padding: EdgeInsets.all(10.0), // kutu içerisindeki boşluğu ayarlar
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0), // kutunun kenarlık özelliklerini ayarlar
        borderRadius: BorderRadius.circular(5.0), // kutunun köşelerinin yuvarlatılması
      ),
      child: Text(
        'Kutu görünümlü yazıbla ',
        style: TextStyle(fontSize: 16.0),
      ),
    ),
      IconButonsl],

  );
}