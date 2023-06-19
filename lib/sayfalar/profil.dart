import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/Anasayfa.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/tekliflerimilistele.dart';

import '../sabitler/satirbilgileri.dart';
import 'islerim.dart';

class profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<profil> {
  User? _user;


  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }
  Future<void> _fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      setState(() {
        _user = currentUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Sayfası'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Anasayfa()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.work),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Islerim()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.file_copy_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TekliflerimiListele()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          if (_user != null) ...[
            CircleAvatar(
              radius: 80,
            ),
            SizedBox(height: 16),
            Text(
              _user!.displayName ?? '',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _user!.email ?? '',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Profil düzenleme sayfasına yönlendirme işlemleri burada yapılabilir.
              },
              child: Text('Profili Düzenle'),
            ),
          ],
          SizedBox(height: 16),
          Text(
            'İlanlarınız',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: fetchFirestoreData(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fetchFirestoreData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('selcukyaman123123').snapshots(),
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
            int sayi = docs.length;
            print(sayi);
            List<Widget> containers = [];
            for (int i = 0; i < sayi; i++) {
              print(sayi);
              var data1 = docs[i].data() as Map<String, dynamic>;
              var denemesibedava = docs[i].id;
              print(denemesibedava);
              var field1 = data1['IsAdi'];
              var field2 = data1['IsFiyati'];
              var field3 = data1['IsAciklama'];
              var oylesine = data1['Kullaniciadi'];
              var field4 = data1['date'];

              // Diğer alanlara da ihtiyaca göre erişebilirsiniz...

              // Verileri kullanarak işlemler yapabilirsiniz
              print('field1: $field1, field2: $field2, field3: $field3, field4: $field4');
              if (_user!.email == oylesine) {
                containers.add(
                  Container(
                    width: MediaQuery.of(context).size.width - 25,
                    child: ProfilTaslak(field1, field3, field2, field4, context, denemesibedava),
                  ),
                );
              }
            }

            return Column(
              children: [
                for (int i = 0; i < containers.length; i++) containers[i],
              ],
            );
          }
        }

        // Veri yoksa veya işlemler tamamlanmadıysa boş bir widget döndürebilirsiniz
        return Container(
          width: MediaQuery.of(context).size.width - 25,
        );
      },
    );
  }
}