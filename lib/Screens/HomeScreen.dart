import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrhairsaloon/Screens/ServicesScreen.dart';
import 'package:mrhairsaloon/Widgets/MyDrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var document = FirebaseFirestore.instance.collection("Slider").doc('Sliders');
  var document2 =
      FirebaseFirestore.instance.collection("DayOffers").doc('OffersDay');
  var document3 =
      FirebaseFirestore.instance.collection("ImageOffer").doc('Offers');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'JustRest',
          style: TextStyle(
              letterSpacing: 3.0,
              fontFamily: GoogleFonts.playfairDisplay().fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 24),
        ),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: document.get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          CarouselSlider(
                              items: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                        image: NetworkImage(data['Slider1']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                        image: NetworkImage(data['Slider2']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                        image: NetworkImage(data['Slider3']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                        image: NetworkImage(data['Slider4']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                        image: NetworkImage(data['Slider5']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                              options: CarouselOptions(
                                  height: 300.0,
                                  aspectRatio: 16 / 9,
                                  enableInfiniteScroll: true,
                                  viewportFraction: 0.9,
                                  autoPlay: true,
                                  autoPlayCurve: Curves.easeInOut,
                                  enlargeCenterPage: true))
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox.fromSize(
                    size: Size(76, 76), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Color(0xFFFFF2E3), // button color
                        child: InkWell(
                          splashColor: Color(0xFFFFF2E3), // splash color
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ServicesScreen(serviceId: "HairCut")));
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/haircut.png'), // icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(76, 76), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Color(0xFFFFF2E3), // button color
                        child: InkWell(
                          splashColor: Color(0xFFFFF2E3), // splash color
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ServicesScreen(
                                        serviceId: "HairTreatment")));
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                  'assets/images/hairtreatment.png') // icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(76, 76), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Color(0xFFFFF2E3), // button color
                        child: InkWell(
                          splashColor: Color(0xFFFFF2E3), // splash color
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ServicesScreen(
                                        serviceId: "HairColor")));
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                  'assets/images/haircolor.png'), // icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(76, 76), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Color(0xFFFFF2E3), // button color
                        child: InkWell(
                          splashColor: Color(0xFFFFF2E3), // splash color
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ServicesScreen(serviceId: "Shaving")));
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/shaving.png'), // icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox.fromSize(
                      size: Size(76, 76), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Color(0xFFFFF2E3), // button color
                          child: InkWell(
                            splashColor: Color(0xFFFFF2E3), // splash color
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ServicesScreen(
                                          serviceId: "Styling")));
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                    'assets/images/styling.png'), // icon
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(76, 76), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Color(0xFFFFF2E3), // button color
                          child: InkWell(
                            splashColor: Color(0xFFFFF2E3), // splash color
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ServicesScreen(
                                          serviceId: "Massage")));
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                    'assets/images/massage.png'), // icon
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(76, 76), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Color(0xFFFFF2E3), // button color
                          child: InkWell(
                            splashColor: Color(0xFFFFF2E3), // splash color
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ServicesScreen(
                                          serviceId: "Facials")));
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                    'assets/images/facials.png'), // icon
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(76, 76), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Color(0xFFFFF2E3), // button color
                          child: InkWell(
                            splashColor: Color(0xFFFFF2E3), // splash color
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServicesScreen(serviceId: "Combo")));
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.more),
                                Text('Combo')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              FutureBuilder(
                  future: document3.get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(data['ImageOffers']),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 450,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Offers of the day",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                      ),
                    ),
                    FutureBuilder(
                        future: document2.get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.network(data['offer1']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.network(data['offer2']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.network(data['offer3']),
                                ),
                              ],
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
