

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selpar_selcuk_yamann_223301109/arayuz.dart';
import 'package:selpar_selcuk_yamann_223301109/main.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/renk.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/satirbilgileri.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/detay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/ilanver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/profil.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/teklifler.dart';
class Anasayfa extends StatelessWidget {
 late BuildContext? context1;
 List<Widget> satirListesi = [];
 User? _user;
 _fetchUserData() async {
   FirebaseAuth auth = FirebaseAuth.instance;
   User? currentUser = auth.currentUser;
   if (currentUser != null) {

       _user = currentUser;

   }
 }
  @override
  Widget build(BuildContext context) {

    _fetchUserData();
    context1=context;
    String Kullanici="";
    print("buraya girdi1");
    final List<String>? message = ModalRoute.of(context)?.settings.arguments as List<String>?;
    print("buraya girdi2");
final double ekran=MediaQuery.of(context).size.height;



        satirListesi.add(fetchFirestoreDatayatay(context,_user!.email.toString())) ;

    return SafeArea(child:
    Scaffold(
      backgroundColor: Renk_Belirle("CFF5E7"),
      body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Arayuz()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Renk_Belirle("009EFF"),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Ana Sayfa",
                          style: TextStyle(color: Renk_Belirle("009EFF")),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IlanVer()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Renk_Belirle("009EFF"),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "İlan Ver",
                          style: TextStyle(color: Renk_Belirle("009EFF")),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => teklifler()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_chart,
                          color: Renk_Belirle("009EFF"),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Teklifler",
                          style: TextStyle(color: Renk_Belirle("009EFF")),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => profil()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Renk_Belirle("009EFF"),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Profil",
                          style: TextStyle(color: Renk_Belirle("009EFF")),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
            height: 150,

              child: Container(

                margin: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width-25,


                child:fetchFirestoreDatayatay(context,_user!.email.toString()),
                  
               
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
          
                 

                    fetchFirestoreData(context,_user!.email.toString())




                  ],
                ),
              ),
            ))
          ]
      ),
    ),
    );
  }
/*
 Widget fetchFirestoreData(BuildContext context) {
   return FutureBuilder<QuerySnapshot>(
     future: FirebaseFirestore.instance.collection('selcukyaman123123').get(),
     builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
         // Sorgu tamamlanana kadar yükleniyor gösterebilirsiniz
         return CircularProgressIndicator();
       }

       if (snapshot.hasError) {
         // Hata durumunda hata mesajını gösterebilirsiniz
         return Text('Hata: ${snapshot.error}');
       }

       if (snapshot.hasData) {
         QuerySnapshot<Object?>? querySnapshot = snapshot.data;
         List<DocumentSnapshot<Object?>>? docs = querySnapshot?.docs;
         if (docs != null && docs.isNotEmpty) {
           int sayi=docs.length;
           print(sayi);
           for(int i=0;i<6; i++){
             print(sayi);
           var data1 = docs[i].data() as Map<String, dynamic>;
           var field1 = data1['IsAdi'];
           var field2 = data1['IsFiyati'];
           var field3 = data1['IsAciklama'];
           var field4 = data1['date'];

           // Diğer alanlara da ihtiyaca göre erişebilirsiniz...

           // Verileri kullanarak işlemler yapabilirsiniz
           print('field1: $field1, field2: $field2, field3: $field3, field4: $field4');

           return Container(
             width: MediaQuery.of(context).size.width - 25,
             child: DikeyTaslak(field1, field3, field2, field4, context),
           );
         }}
       }

       // Veri yoksa veya işlemler tamamlanmadıysa boş bir widget döndürebilirsiniz
       return Container(
         width: MediaQuery.of(context).size.width - 25,
       );
     },
   );
 }
*/
  Widget fetchFirestoreData(BuildContext context, String SuAnkiKullanici) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('selcukyaman123123').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        }

        if (snapshot.hasData) {
          QuerySnapshot<Object?>? querySnapshot = snapshot.data;
          List<DocumentSnapshot<Object?>>? docs = querySnapshot?.docs;
          if (docs != null && docs.isNotEmpty) {
            List<Widget> containers = [];
            for (var doc in docs) {
              var data1 = doc.data() as Map<String, dynamic>;
              var field1 = data1['IsAdi'];
              var field2 = data1['IsFiyati'];
              var field3 = data1['IsAciklama'];
              var oylesine = data1['Kullaniciadi'];
              var field4 = data1['date'];
              var path = data1['path'];

              DateTime currentDate = DateTime.now();
              var dateFormatter = DateFormat('dd/MM/yyyy');
              DateTime? dataDate = dateFormatter.parse(field4);
              if (oylesine != SuAnkiKullanici && dataDate!.isAfter(currentDate)) {
                print('field1: $field1, field2: $field2, field3: $field3, field4: $field4');

                containers.add(
                  Container(
                    width: MediaQuery.of(context).size.width - 25,
                    child: DikeyTaslak(field1,path, field3, field2, field4, context, oylesine),
                  ),
                );
              }
            }

            return Column(
              children: containers,
            );
          }
        }

        return Container(
          width: MediaQuery.of(context).size.width - 25,
        );
      },
    );
  }
  ScrollController _scrollController = ScrollController();
  int adet=0;
  Widget fetchFirestoreDatayatay(BuildContext context, String currentUser) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('selcukyaman123123').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        }

        if (snapshot.hasData) {
          QuerySnapshot<Object?>? querySnapshot = snapshot.data;
          List<DocumentSnapshot<Object?>>? docs = querySnapshot?.docs;
          if (docs != null && docs.isNotEmpty) {
            int count = docs.length;
            print(count);
            List<Widget> containers = [];
            for (int i = 0; i < count; i++) {
              var data = docs[i].data() as Map<String, dynamic>;
              var field1 = data['IsAdi'];
              var field2 = data['IsFiyati'];
              var field3 = data['IsAciklama'];
              var username = data['Kullaniciadi'];
              var field4 = data['date'];
              DateTime currentDate = DateTime.now();
              var dateFormatter = DateFormat('dd/MM/yyyy');
              DateTime? dataDate = dateFormatter.parse(field4);
              if (username != currentUser && dataDate!.isAfter(currentDate)) {
                print('field1: $field1, field2: $field2, field3: $field3, field4: $field4');

                if (context != null) {
                  adet++;
                  print(adet);
                  containers.add(
                    Container(
                      width: 400, // Genişliği burada sınırla
                      child: YatayTaslak(field1, field3, field2, field4, context, username),
                    ),
                  );
                }
              }
            }

            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: containers.map((container) {
                      return Container(
                        width: 400, // Genişliği burada sınırla
                        child: container,
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
        }

        return Container(
          width: MediaQuery.of(context).size.width - 25,
        );
      },
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