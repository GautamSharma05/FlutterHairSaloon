import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrhairsaloon/Screens/AboutUs.dart';
import 'package:mrhairsaloon/Screens/BookingScreen.dart';
import 'package:mrhairsaloon/Screens/HomeScreen.dart';
import 'package:mrhairsaloon/Screens/LoginScreen.dart';
import 'package:mrhairsaloon/Screens/PrivacyPolicy.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final imageurl =
      'https://cdn4.vectorstock.com/i/thumb-large/83/13/barber-handsome-man-with-beard-and-mustache-vector-22318313.jpg';

  var document = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      FutureBuilder(
          future: document.get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                children: [
                  DrawerHeader(
                      padding: EdgeInsets.zero,
                      child: UserAccountsDrawerHeader(
                        margin: EdgeInsets.zero,
                        accountName: Text(data['FullName']),
                        accountEmail: Text(data['Email']),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(imageurl),
                        ),
                      )),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                      textScaleFactor: 1.2,
                    ),
                    onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen())),
                  ),
                  ListTile(
                    leading: Icon(Icons.alarm_on),
                    title: Text(
                      'Your Bookings',
                      textScaleFactor: 1.2,
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingScreen())),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      'Contact Us',
                      textScaleFactor: 1.2,
                    ),
                    onTap: () => launch("tel://7425883656"),
                  ),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text(
                      'invite',
                      textScaleFactor: 1.2,
                    ),
                    onTap: () => Share.share(
                        'Check Out My Youtube Video https://youtu.be/PuZrP_PyCCY',
                        subject: 'Look what I made!'),
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text(
                      'About us',
                      textScaleFactor: 1.2,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip),
                    title: Text(
                      'Privacy Policy',
                      textScaleFactor: 1.2,
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy())),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Log Out',
                      textScaleFactor: 1.2,
                    ),
                    onTap: () => FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()))),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    ]));
  }
}
