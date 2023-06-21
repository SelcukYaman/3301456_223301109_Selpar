import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class ChartData {
  final String duration;
  final int price;

  ChartData(this.duration, this.price);
}

class teklifler extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      // Kullanıcı oturum açmamışsa bir hata mesajı gösterelim
      return Scaffold(
        appBar: AppBar(
          title: Text('İlan Listesi'),
        ),
        body: Center(
          child: Text('Oturum açmış bir kullanıcı bulunamadı.'),
        ),
      );
    }

    final String kullaniciEpostasi = user!.email!;

    return Scaffold(
      appBar: AppBar(
        title: Text('İlan Listesi'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('selcukyaman321321')
            .where('KayitSahibi', isEqualTo: kullaniciEpostasi)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> ilanlar = snapshot.data!.docs;

            // İş adına göre gruplama yapmak için bir Map kullanalım
            Map<String, List<QueryDocumentSnapshot>> gruplanmisIlanlar = {};

            // İlanları gruplara ayıralım
            ilanlar.forEach((ilan) {
              String isAdi = ilan['date'];
              if (gruplanmisIlanlar.containsKey(isAdi)) {
                gruplanmisIlanlar[isAdi]!.add(ilan);
              } else {
                gruplanmisIlanlar[isAdi] = [ilan];
              }
            });

            // Gruplanmış ilanları ListView.builder içinde kullanalım
            return ListView.builder(
              itemCount: gruplanmisIlanlar.length,
              itemBuilder: (context, index) {
                String baslik = gruplanmisIlanlar.keys.elementAt(index);
                List<QueryDocumentSnapshot> ilanGrubu =
                gruplanmisIlanlar[baslik]!;

                // İlan grubunu Card şeklinde gösterelim
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      baslik,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Container(
                        height: 300,
                        child: SfCircularChart(
                          series: <CircularSeries>[
                            PieSeries<ChartData, String>(
                              dataSource: ilanGrubu.map((ilan) {
                                String aciklama = ilan['IsAciklama'];
                                int fiyat = int.parse( ilan['IsAciklama']);
                                return ChartData(aciklama, fiyat);
                              }).toList(),
                              xValueMapper: (ChartData chartData, _) =>
                              chartData.duration,
                              yValueMapper: (ChartData chartData, _) =>
                              chartData.price,
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: ilanGrubu.map((ilan) {
                          String aciklama = ilan['IsAciklama'];
                          String olusturmaTarihi = ilan['date'];
                          String fiyat = ilan['IsFiyati'];
                          String teklifVeren = ilan['Kullaniciadi'];
                          String issahibi = ilan["KayitSahibi"];
                          String id = ilan.id.toString();
                          return ListTile(
                            title: Text(
                              "Teklif: $aciklama",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  'İş Günü: $fiyat',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Mesaj: $olusturmaTarihi',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Teklifi Veren E-posta: $teklifVeren',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                TeklifOnayla(aciklama, olusturmaTarihi, fiyat,
                                    teklifVeren, issahibi, id);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text('Onayla'),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  TeklifOnayla(String fiyat, String isinadi, String sure, String teklifVeren,
      String issahibi, String id) async {
    // Firebase'in başlatılması
    await Firebase.initializeApp();

    // Firestore referansını al
    final firestore = FirebaseFirestore.instance;

    try {
      // yaman223301109 koleksiyonuna verileri ekle
      await firestore.collection('yaman223301109').add({
        'fiyat': fiyat,
        'isinadi': isinadi,
        'sure': sure,
        'teklifVeren': teklifVeren,
        'issahibi': issahibi,
      });
      print('Veriler yaman223301109 koleksiyonuna kaydedildi.');

      // selcukyaman321321 koleksiyonundan ilgili veriyi sil
      await firestore.collection('selcukyaman321321').doc(id).delete();
      print('Veri selcukyaman321321 koleksiyonundan silindi.');
    } catch (e) {
      print('Hata: $e');
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: teklifler(),
    );
  }
}