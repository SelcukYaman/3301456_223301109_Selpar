import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Islerim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İşlerim'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('yaman223301109').snapshots(),
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
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    var isAdi = data['isinadi'];
                    var isVeren = data['teklifVeren'];
                    var isFiyati = data['fiyat'];
                    var isGunu = data['sure'];
                    var isAciklamasi = data['issahibi'];

                    return Card(
                      child: ListTile(
                        title: Text(isAdi.toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('İş Veren: $isVeren'),
                            Text('İş Fiyatı: $isFiyati'),
                            Text('İş Günü: $isGunu'),
                            Text('İş Veren: $isAciklamasi'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }

            // Veri yoksa veya işlemler tamamlanmadıysa boş bir widget döndürebilirsiniz
            return Container(
              alignment: Alignment.center,
              child: Text('İşler bulunamadı.'),
            );
          },
        ),
      ),
    );
  }
}