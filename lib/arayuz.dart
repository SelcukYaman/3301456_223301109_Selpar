import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/renk.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/Anasayfa.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/kayitol.dart';

class Arayuz extends StatefulWidget {
  const Arayuz({Key? key}) : super(key: key);

  @override
  State<Arayuz> createState() => _ArayuzState();
}

class _ArayuzState extends State<Arayuz> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner : false,home: Scaffold(body: Center(child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Renk_Belirle(renk)
      ),
      child: Container(

        decoration: BoxDecoration(
            border: Border.all(color: Renk_Belirle(grirenk),width: 15,)
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Renk_Belirle(renk),
              border: Border.all(color: Renk_Belirle(renk),width: 15,)
          ),
          child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [



            _textform_kullAdi,_textForm_sifre,girisbutton,kaydolbutton
          ],
          ),
        ),
      ),
    ),
    ),
    ),
    );

  }
  late String kullaniciadi="";
  late String kullanicisifre="";
  @override
  // TODO: implement widget
  Widget get girisbutton => Center(
    child: Container(
      height: 44,
      width: 200,

      child: FilledButton(onPressed: () {
        print(kullaniciadi);
        print(kullanicisifre);
        if(kullaniciadi=='selcuk'&&kullanicisifre=='sss'){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Anasayfa(),
        settings: RouteSettings(
        arguments: kullaniciadi+kullanicisifre, // aktarılacak veri
        ), ),
          );}
      },style: FilledButton.styleFrom(backgroundColor: Renk_Belirle("569DAA")),
        child:Text("Giriş",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'Source Sans Pro',color: Renk_Belirle("577D86")),),),

    ),
  );
  Widget get kaydolbutton => Center(
    child: Container( alignment:  Alignment.topLeft,
      height: 44,
      width: 200,
      child: TextButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Kayitol(),
           ),
        );

      },
        child:Text("Kaydol",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'Source Sans Pro',color: Renk_Belirle("577D86")),
        
        ),
      ),

    ),
  );
  late bool sifregizle=true;
  Widget get _textform_kullAdi => Center(
    child: Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      height: 44,
      width: 380,
      child: TextField(
        onChanged: (text) {
          setState(() {
            kullaniciadi = text;
          });},
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15, 1, 1, 1),
          filled: true,
          //focusedBorder: outlineInputBorder,
          focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: "kullanıcı Adı",
          hintStyle: TextStyle(color: Renk_Belirle("569DAA")),
          fillColor: Renk_Belirle("B9EDDD"),
        ),
      ),
    ),
  );
  Widget get _textForm_sifre => Center(
    child: Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: SizedBox(
        height: 44,
        width: 380,

        child: TextField(
          obscureText: sifregizle,
  onChanged: (text) {
  setState(() {
  kullanicisifre = text;
  });},
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  sifregizle= !sifregizle;
                });
              },
              icon: Icon(Icons.remove_red_eye),
              color: Colors.blueAccent,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            filled: true,
            //focusedBorder: outlineInputBorder,
            focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: "Şifre",
            hintStyle: TextStyle(color: Renk_Belirle("569DAA")),
            fillColor: Renk_Belirle("B9EDDD"),
          ),
        ),
      ),
    ),
  );
}
