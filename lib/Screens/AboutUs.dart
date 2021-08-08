import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('AboutUs'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'what are we?',
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'M.R Saloon is the highest rated beauty service provider in BEAWAR! We are shaping the future of the beauty industry one step at a time. Our experts provide at home salon service to make our pricious clients experience more comfortable and hygien. \n\nAnd we have good new! M.R Saloon has expanded its services range including home services into the list. '),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'How Did it start?',
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text: 'M.R Saloon Founded By',
                        ),
                        TextSpan(
                            text: '\tGAUTAM SHARMA',
                            style: TextStyle(color: Colors.pink)),
                        TextSpan(
                            text:
                                '\tis known for his enterpreneurship skills and pure dedication to his work. Started in 2021, M.R Saloon began with the goal of making beauty service cheapest in the market and transparent and it would not be wrong to say that we have nailed so far!'),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
