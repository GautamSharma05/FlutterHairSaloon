import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'OrderBookingScreen.dart';

class DetailScreen extends StatefulWidget {
  final String serviceName, serviceId;
  DetailScreen({required this.serviceName, required this.serviceId});

  @override
  _DetailScreenState createState() =>
      _DetailScreenState(serviceName, serviceId);
}

class _DetailScreenState extends State<DetailScreen> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Services");
  String serviceName, serviceId;
  _DetailScreenState(this.serviceName, this.serviceId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: collectionReference
                    .doc(serviceId)
                    .collection("subtype")
                    .where('ServiceName', isEqualTo: serviceName)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Text('Error');
                  }
                  if (snapshot.hasData) {
                    return displayDetailServices(context, snapshot);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget displayDetailServices(BuildContext context, snapshot) {
    return Column(
        children: snapshot.data!.docs
            .map<Widget>((e) => Column(
                  children: [
                    SizedBox(
                      height: 2.0,
                    ),
                    Image.network(e['SampleImage']),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          e['ServiceName'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_alarm,
                            color: Colors.pink,
                          ),
                          Text('\t\t\t${e['Time']}',
                              style: TextStyle(
                                  color: Colors.pink, letterSpacing: 1.0)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0, top: 16.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '₹${e['SellingPrice']}/-',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.0),
                          )),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'WHY FROM JustRest - At HOME ${e['ServiceName']}?',
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 18,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '\u2022 Enjoy your best service at your doorstep now. \n \u2022 Our services providers are well trained for COVID-19 and precautions. \n \u2022 Our experts use disinfectants to disinfect their equipment, tools and working area. \n \u2022 Our experts update their daily temperature over their JustRest Partner App \n \u2022 We only use disposable bed sheets,disposable masks and disposable razors etc. \n \u2022 Our experts use their own vehicle and avoid touch greetings \n \u2022 Our experts will provide a disposable marks and a pair of gloves to the customers.',
                        style: TextStyle(letterSpacing: 1.0),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('WHY SHOULD YOU GET THIS DONE?',
                            style: TextStyle(
                                color: Colors.pink,
                                fontSize: 18,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            '\u2022 Enhance your personasilty. \n \u2022 Rountine maintenance \n \u2022 To get desired look'),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('M.R SALOON SUGGESTION',
                            style: TextStyle(
                                color: Colors.pink,
                                fontSize: 18,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            '\u2022 Consult our expert for better experience and suggestion'),
                      ),
                    ),
                    Divider(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderBookingScreen(
                                      serviceName: e['ServiceName'])));
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 80.0, right: 80.0)),
                        child: Text(
                          'Book Now',
                          style: TextStyle(fontSize: 18, letterSpacing: 1.0),
                        )),
                    Divider()
                  ],
                ))
            .toList());
  }
}
