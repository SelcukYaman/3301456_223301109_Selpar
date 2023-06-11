import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeklifGuncelle extends StatefulWidget {
  final String ilanId;

  const TeklifGuncelle({required this.ilanId});

  @override
  _TeklifGuncelleState createState() => _TeklifGuncelleState();
}

class _TeklifGuncelleState extends State<TeklifGuncelle> {
  TextEditingController _isFiyatiController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _aciklamaController = TextEditingController();
  TextEditingController _isBasligiController = TextEditingController();

  @override
  void dispose() {
    _isFiyatiController.dispose();
    _dateController.dispose();
    _aciklamaController.dispose();
    _isBasligiController.dispose();
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
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          'Teklif Güncelle',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
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

              controller: _isBasligiController,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                labelText: 'İş Başlığı',
                labelStyle: TextStyle(color: Colors.blueAccent),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
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
              controller: _isFiyatiController,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                labelText: 'Yeni İş Fiyatı',
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
                labelText: 'Yeni Tarih',
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
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                String yeniIsFiyati = _isFiyatiController.text;
                String yeniDate = _dateController.text;
                String yeniIsAdi = _isBasligiController.text;
                String yeniIsAciklama = _aciklamaController.text;
                if (yeniIsFiyati.isNotEmpty && yeniDate.isNotEmpty) {
                  guncelleTeklif(
                    widget.ilanId,
                    yeniIsFiyati,
                    yeniDate,
                    yeniIsAdi,
                    yeniIsAciklama,
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
    );
  }

  void getIlanDetails() {
    FirebaseFirestore.instance
        .collection('selcukyaman123123')
        .doc(widget.ilanId)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _isFiyatiController.text = documentSnapshot.get('IsFiyati');
          _dateController.text = documentSnapshot.get('date');
          _aciklamaController.text = documentSnapshot.get('IsAciklama');
          _isBasligiController.text = documentSnapshot.get('IsAdi');
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
      String yeniIsFiyati,
      String yeniDate,
      String yeniIsAdi,
      String yeniIsAciklama,
      ) {
    FirebaseFirestore.instance
        .collection('selcukyaman123123')
        .doc(ilanId)
        .update({
      'IsFiyati': yeniIsFiyati,
      'date': yeniDate,
      'IsAdi': yeniIsAdi,
      'IsAciklama': yeniIsAciklama,
    }).then((_) {
      print('Teklif güncellendi: $ilanId');
    }).catchError((error) {
      print('Teklif güncelleme hatası: $error');
    });
  }
}