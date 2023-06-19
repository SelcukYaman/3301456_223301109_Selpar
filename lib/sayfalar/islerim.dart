import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Islerim extends StatelessWidget {
 // Add a field to store the logged-in user ID or username

   // Add a constructor to initialize the logged-in user
   User? _user;

   Future<void> _fetchUserData() async {
     FirebaseAuth auth = FirebaseAuth.instance;
     User? currentUser = auth.currentUser;
     if (currentUser != null) {

         _user = currentUser;

     }
   }
  @override
  Widget build(BuildContext context) {
    _fetchUserData();
    return Scaffold(
      appBar: AppBar(
        title: Text('İşlerim'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('yaman223301109')
              .where('teklifVeren', isEqualTo:    _user!.email )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for the query to complete
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              // Display an error message if there's an error
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
                            Text('İşi ALan: $isVeren'),
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

            // Display a message if there's no data or the operations are not completed
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