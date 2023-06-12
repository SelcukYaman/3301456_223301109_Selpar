import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeklifGuncelle extends StatefulWidget {
  final String ilanId;

  const TeklifGuncelle({required this.ilanId});

  @override
  _TeklifGuncelleState createState() => _TeklifGuncelleState();
}

class _TeklifGuncelleState extends State<TeklifGuncelle> {
  TextEditingController _aciklamaController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _fiyatController = TextEditingController();
  TextEditingController _teklifVerenController = TextEditingController();
  TextEditingController _isSahibiController = TextEditingController();

  @override
  void dispose() {
    _aciklamaController.dispose();
    _dateController.dispose();
    _fiyatController.dispose();
    _teklifVerenController.dispose();
    _isSahibiController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getIlanDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          'Teklif Güncelle',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView (
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.greenAccent, // Arka plan rengi (beyaz)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'İş Fiyatı Güncelle',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _aciklamaController,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'Açıklama',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _dateController,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'Tarih',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _fiyatController,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'İş Fiyatı',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _teklifVerenController,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'Teklif Veren',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'İş Sahibi: ${_isSahibiController.text}',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  String aciklama = _aciklamaController.text;
                  String tarih = _dateController.text;
                  String fiyat = _fiyatController.text;
                  String teklifVeren = _teklifVerenController.text;
                  String isSahibi = _isSahibiController.text;
                  if (aciklama.isNotEmpty && tarih.isNotEmpty) {
                    guncelleTeklif(
                      widget.ilanId,
                      aciklama,
                      tarih,
                      fiyat,
                      teklifVeren,
                      isSahibi,
                    );
                    Navigator.pop(context); // Sayfayı kapat
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  'Güncelle',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getIlanDetails() {
    FirebaseFirestore.instance
        .collection('selcukyaman321321')
        .doc(widget.ilanId)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _aciklamaController.text = documentSnapshot.get('IsAciklama');
          _dateController.text = documentSnapshot.get('date');
          _fiyatController.text = documentSnapshot.get('IsFiyati');
          _teklifVerenController.text = documentSnapshot.get('Kullaniciadi');
          _isSahibiController.text = documentSnapshot.get('KayitSahibi');
        });
      } else {
        print('Belge bulunamadı: ${widget.ilanId}');
      }
    }).catchError((error) {
      print('Belge alınırken hata oluştu: $error');
    });
  }

  void guncelleTeklif(
      String ilanId,
      String aciklama,
      String tarih,
      String fiyat,
      String teklifVeren,
      String isSahibi,
      ) {
    FirebaseFirestore.instance
        .collection('selcukyaman321321')
        .doc(ilanId)
        .update({
      'IsAciklama': aciklama,
      'date': tarih,
      'IsFiyati': fiyat,
      'Kullaniciadi': teklifVeren,
      'KayitSahibi': isSahibi,
    }).then((value) {
      print('Teklif güncellendi: $ilanId');
    }).catchError((error) {
      print('Teklif güncellenirken hata oluştu: $error');
    });
  }
}