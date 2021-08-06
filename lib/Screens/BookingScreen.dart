import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var collectionReference = FirebaseFirestore.instance
      .collection("Bookings")
      .where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Your bookings'),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: collectionReference.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs
                      .map((e) => Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: BoxConstraints(
                              maxHeight: double.infinity,
                            ),
                            child: Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Image.network(e['BookingImage']),
                                    title: Text(e['Service']),
                                    subtitle: Text('Slot:${e['Slot']}'),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                            Text('Address:\t${e['Address']}')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            'Specialist:\t${e['WorkerName']}')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            'Specialist Mobile Number:\t${e['WorkerMobileNumber']}')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            'Booking date:\t${(e['Date']).toDate()}')),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ))
        ],
      ),
    );
  }
}
