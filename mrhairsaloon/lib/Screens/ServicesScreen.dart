import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrhairsaloon/Screens/OrderBookingScreen.dart';

import 'DetailScreen.dart';

class ServicesScreen extends StatefulWidget {
  final String serviceId;
  ServicesScreen({required this.serviceId});

  @override
  _ServicesScreenState createState() => _ServicesScreenState(serviceId);
}

class _ServicesScreenState extends State<ServicesScreen> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Services");
  String serviceId;
  _ServicesScreenState(this.serviceId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(serviceId),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: collectionReference
                    .doc(serviceId)
                    .collection("subtype")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Text('Error');
                  }
                  if (snapshot.hasData) {
                    return displayServices(context, snapshot);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget displayServices(BuildContext context, snapshot) {
    return ListView(
      children: snapshot.data!.docs
          .map<Widget>(
            (e) => InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  padding: new EdgeInsets.all(10.0),
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.network(
                            e['SampleImage'],
                          ),
                          title: Text(
                            e['ServiceName'],
                            style: TextStyle(color: Colors.pink),
                          ),
                          subtitle: Text(e['under']),
                          trailing: Text(
                            '₹${e['SellingPrice']}/-',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Price:\t₹${e['SellingPrice']}/-',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              '${(double.parse(e['ActualPrice']) - double.parse(e['SellingPrice'])) / double.parse(e['ActualPrice']) * 100}%OFF',
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('₹${e['ActualPrice']}/-',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Lorem Ipsum is simply dummy texhe printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                        ),
                        ButtonBar(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderBookingScreen(
                                                  serviceName:
                                                      e['ServiceName'])));
                                },
                                child: Text('Book Now')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                              serviceName: e['ServiceName'],
                                              serviceId: serviceId)));
                                },
                                child: Text('View Details'))
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          )
          .toList(),
    );
  }
}
