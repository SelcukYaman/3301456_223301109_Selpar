import 'package:flutter/material.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../arayuz.dart';
import '../sabitler/renk.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Kayitol extends StatefulWidget {
  const Kayitol({Key? key}) : super(key: key);

  @override
  State<Kayitol> createState() => _KayitolState();
}

class _KayitolState extends State<Kayitol> {
  TextEditingController _eposta = TextEditingController();
  TextEditingController _sifre = TextEditingController();
  TextEditingController _telefon = TextEditingController();
  TextEditingController _kuladi = TextEditingController();
  Tema tema=Tema();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Renk_Belirle("216353")
              ),
              child:Column(
                children: [
                  Container(

                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        border: Border.all(color: Renk_Belirle("216353"),width: 15,)
                    ),
                    child: Container(

                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Renk_Belirle("F6F6F6"),
                          border: Border.all(color: Renk_Belirle("F6F6F6"),width: 15,)
                      ),
                      child: SingleChildScrollView(
                        child: Stack(children: [ Positioned(left:0,
                          top: 0,
                          child: Padding(child:TextButton(onPressed: (){  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Arayuz(),
                            ),
                          );},child:InkWell(child: Icon(Icons.home,color: Renk_Belirle("BDF2D5"),)))
                            , padding: EdgeInsets.only(top: 0),),),Padding(padding: EdgeInsets.only(left: 35,top: 3),child: TextButton(onPressed: (){  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Arayuz(),
                          ),
                        );},child: Text("Ana Sayfa" ,style: GoogleFonts.roadRage(color: Renk_Belirle("BDF2D5")),),),),birlestirici]),
                      ),
                    ),
                  )
                 ],

              ),
            ),
          ),

        );
  }
  @override
  // TODO: implement widget
  Widget get birlestirici => Container(
    margin: EdgeInsets.only(top: 10,bottom: 10),
   child: Column(

     children: [kullanicitext,Sifretext,Epostatext,Teltext,KayitButton],
   ),
  );
  Widget get kullanicitext => Container(
    decoration: tema.BoxDec(),
    margin: EdgeInsets.all(40),
    padding: EdgeInsets.only(left: 15,top: 5,right: 15,bottom: 5),
    child: TextField(
      decoration: tema.InputDec("Kullanıcı Adı",Icons.people_alt_outlined),

    ),
  );
  String butonrenk="75DAAD";
  Widget get KayitButton => Container(

    margin: EdgeInsets.all(40),

    child: ElevatedButton(onPressed: () {
      String EPOS=_eposta.text;
      String Esif=_sifre.text;
      String Eisim=_kuladi.text;
      String Ephone=_telefon.text;
      registerUser(Eisim,EPOS,Ephone, Esif);

    },
     child: Text("Kayıt Ol",style:GoogleFonts.roadRage(color: Renk_Belirle("ffffff"),fontSize: 25) ,),
      style: FilledButton.styleFrom(backgroundColor: Renk_Belirle("216353"),fixedSize: Size(175, 50)),

    ),
  );
  late bool sifregizleme=true;
  Widget get Sifretext => Container(
    decoration: tema.BoxDec(),
    margin: EdgeInsets.all(40),
    padding: EdgeInsets.only(left: 15,top: 5,right: 15,bottom: 5),
    child: TextField(
      controller: _sifre,
      obscureText: sifregizleme,
      decoration:InputDecoration(
        border:  InputBorder.none,
        hintStyle: GoogleFonts.roadRage(color: Colors.white),

        prefixIcon: Icon(Icons.key,color: Colors.white,),
        hintText: "Kullanıcı Şifre",
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              sifregizleme= !sifregizleme;
            });
          },
          icon: Icon(Icons.remove_red_eye,color: Colors.black,),
          color: Colors.blueAccent,
        ),
      ),

    ),
  );Widget get Epostatext => Container(
    decoration: tema.BoxDec(),
    margin: EdgeInsets.all(40),
    padding: EdgeInsets.only(left: 15,top: 5,right: 15,bottom: 5),
    child: TextField(
      controller: _eposta,
      decoration: tema.InputDec("E-Posta",Icons.email),

    ),
  );Widget get Teltext => Container(

    decoration: tema.BoxDec(),
    margin: EdgeInsets.all(40),
    padding: EdgeInsets.only(left: 15,top: 5,right: 15,bottom: 5),
    child: TextField(
      decoration: tema.InputDec("Telefon",Icons.phone),

    ),
  );
  bool deneme=false;
  void sontainer() async{
     if(deneme){
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => Arayuz(),
  ),
  );
}}
  Future<void> registerUser(String fullName, String username, String phone, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      deneme=true;
      sontainer();

      print('Kullanıcı başarıyla kaydedildi.');
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'phone': phone,
      });


    } catch (e) {
      print('Kayıt sırasında bir hata oluştu: $e');
    }
  }
}
