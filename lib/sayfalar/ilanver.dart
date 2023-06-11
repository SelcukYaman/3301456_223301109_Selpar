import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/renk.dart';
import 'package:intl/intl.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/Anasayfa.dart';
import '../arayuz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class IlanVer extends StatefulWidget {
  const IlanVer({Key? key}) : super(key: key);

  @override
  State<IlanVer> createState() => _IlanVerState();

}

class _IlanVerState extends State<IlanVer> {
  User? _user;
  DatabaseReference _databaseRef = FirebaseDatabase.instance.reference();
  TextEditingController  IsKonu= TextEditingController();
  TextEditingController  IsFiyat= TextEditingController();
  TextEditingController  IsAciklama= TextEditingController();
  Future<void> _fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      setState(() {
        print("buraya girdi kod doğru");
        _user = currentUser;
      });
    }
  }

  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    _fetchUserData();
    final String? message = ModalRoute.of(context)?.settings.arguments as String?;
List<String> data=[];
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
          child: SingleChildScrollView(
            child: Container(
height: MediaQuery.of(context).size.height-84,
                  decoration: BoxDecoration(
                      border: Border.all(color: Renk_Belirle("3AFCEF"),width: 15,)
                  ),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Renk_Belirle(renk),
                          border: Border.all(color: Renk_Belirle(renk),width: 15,)
                      ),
                      child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [

                        Konu("İşin Konusu",75,IsKonu),
                        Konu("İşin Fiyat",75,IsFiyat),
                        Konu("İşin Açıklaması",125,IsAciklama),
                        Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width/3,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Renk_Belirle("32D9C9"),width: 15,),
                                    color: Renk_Belirle("32D9C9"),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary:Renk_Belirle("32D9C9"),

                                    ),
                                    onPressed: () => _selectDate(context),
                                    child: AutoSizeText("Tarih Seç",style: GoogleFonts.quicksand()),
                                  ),
                                ) ,

                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Renk_Belirle("43F0DC"),width: 15,),
                                    color: Renk_Belirle("43F0DC"),
                                  ),
                                  child: SizedBox(
                                    height: 18,

                                    child: Container(
                                        child: Text(
                                          _selectedDate == null
                                              ? 'Tarih Seçilmedi'
                                              : 'Seçtiğiniz Tarih: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                                        ),
                                    ),

                                  ),
                                )

                              ],
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width/2,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: FilledButton(onPressed: (){
                            data.clear();
                            data.add(IsKonu.text);
                            data.add(IsAciklama.text);
                            data.add(IsFiyat.text);
                            data.add('${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'.toString());
                            print(data[0]);
                            print(data[1]);
                            print(data[2]);
                            print(data[3]);
                            print('${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'.toString()+IsAciklama.text+IsKonu.text+IsFiyat.text+_user!.email.toString());
                            createCollectionWithAutoID('${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'.toString(),IsAciklama.text,IsKonu.text,IsFiyat.text,_user!.email.toString());

                            Navigator.push(
                              context!,

                              MaterialPageRoute(builder: (context) => Anasayfa(),
                                settings: RouteSettings(
                                  arguments:data , // aktarılacak veri
                                ),
                              ),
                            );
                          },
                              child: AutoSizeText("İlan Ver",
                                  minFontSize: 25,style: GoogleFonts.quicksand(
                                      color: Colors.black,
                                      textStyle: TextStyle()
                                  )),
                              style: FilledButton.styleFrom(backgroundColor: Renk_Belirle("32D9C9")),



                          ),
                        )

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
  Widget Konu(String Baslik ,double Yukseklik,TextEditingController VeriAta){
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
                controller:VeriAta ,
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




  void createCollectionWithAutoID(String date,String aciklama,String adi,String fiyati,String Kullaniciadi) {

    FirebaseFirestore.instance.collection('selcukyaman123123').add({

      'date': date,
      'IsAciklama': aciklama,
      'IsAdi': adi,
      'IsFiyati': fiyati,
      'Kullaniciadi': Kullaniciadi,

    })
        .then((value) {
      print('Tablo oluşturuldu ve veri eklendi. Tablo ID: ${value.id}');
    })
        .catchError((error) {
      print('Hata: $error');
    }); print("dgksjkjg"+date);
  }


}
