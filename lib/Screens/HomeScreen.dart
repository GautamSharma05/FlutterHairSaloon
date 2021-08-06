import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mrhairsaloon/Screens/ServicesScreen.dart';
import 'package:mrhairsaloon/Widgets/MyDrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('M.R Saloon'),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              CarouselSlider(
                  items: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://bizimages.withfloats.com/actual/5f696573ad51d2000178fc9a.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://5.imimg.com/data5/GI/HB/DI/SELLER-54443168/wedding-bridal-makeup-service-500x500.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://i.pinimg.com/736x/88/7c/81/887c81a287ef4039d8783b9637269726.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://i.pinimg.com/originals/48/d9/3e/48d93ec1f02fcf26a05244d71f791c99.jpg"),
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
                      enlargeCenterPage: true)),
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
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/beauty-salon-promotion-design-template-71874bee1e561eb888d7c1ae3215a598_screen.jpg?ts=1584375145"),
                ),
              ),
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                          "https://www.lakmesalon.in/sk-eu/content/dam/brands/lakme/india/1420324-offer-slider2.jpg.rendition.1960.1960.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                          "https://www.lakmesalon.in/sk-eu/content/dam/brands/lakme/india/1420324-offer-slider2.jpg.rendition.1960.1960.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                          "https://www.lakmesalon.in/sk-eu/content/dam/brands/lakme/india/1420324-offer-slider2.jpg.rendition.1960.1960.jpg"),
                    ),
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
