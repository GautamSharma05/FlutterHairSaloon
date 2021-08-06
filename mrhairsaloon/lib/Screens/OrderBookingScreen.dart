import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:mrhairsaloon/Screens/BookingScreen.dart';

class OrderBookingScreen extends StatefulWidget {
  final String serviceName;
  OrderBookingScreen({required this.serviceName});

  @override
  _OrderBookingScreenState createState() =>
      _OrderBookingScreenState(serviceName);
}

class _OrderBookingScreenState extends State<OrderBookingScreen> {
  var document = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  String serviceName;
  _OrderBookingScreenState(this.serviceName);
  int _currentStep = 0;
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();

  continued() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // ignore: unnecessary_statements
        _currentStep < 2 ? setState(() => _currentStep += 1) : addUser();
      });
    }
  }

  cancel() {
    // ignore: unnecessary_statements
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  DateTime _selectedValue = DateTime.now();
  String address = "";
  String name = "";
  String mobileNumber = "";
  String postCode = "";
  String valueChoose = '9:00AM';
  List timeSlot = [
    '9:00AM',
    '10:00AM',
    '11:00AM',
    '12:00PM',
    '01:00PM',
    '02:00PM',
    '04:00PM',
    '05:00PM',
    '06:00PM',
    '07:00PM',
    '08:00PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Book Order'),
      ),
      body: Stepper(
          physics: ScrollPhysics(),
          currentStep: _currentStep,
          onStepTapped: (step) => tapped(step),
          onStepContinue: continued,
          onStepCancel: cancel,
          steps: [
            Step(
              title: Text('Address'),
              content: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _addressController,
                      decoration:
                          InputDecoration(labelText: 'Permanent Address'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Address cannot be empty";
                        }
                        address = value;
                      },
                    ),
                    TextFormField(
                      controller: _postCodeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Postcode'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "PostCode cannot be empty";
                        }
                        if (value != '305901') {
                          return "Current We are available in only 'BEAWAR' city";
                        }
                        postCode = value;
                      },
                    ),
                  ],
                ),
              ),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 0 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: new Text('Slots'),
              content: Column(
                children: <Widget>[
                  DatePicker(
                    DateTime.now(),
                    width: 60,
                    height: 90,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.black,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      setState(() {
                        _selectedValue = date;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Select Your Slot',
                    style: TextStyle(fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                        hint: Text('Select Your Slot'),
                        value: valueChoose,
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            valueChoose = newValue.toString();
                          });
                        },
                        items: timeSlot.map((valueSlot) {
                          return DropdownMenuItem(
                              value: valueSlot, child: Text(valueSlot));
                        }).toList()),
                  )
                ],
              ),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 1 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: Text('Final Details'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: document.get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                              Text(
                                'Name: ${name = data['FullName']}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                  'Mobile Number :${mobileNumber = data['MobileNumber']}',
                                  style: TextStyle(fontSize: 16)),
                              Text('Address: $address',
                                  style: TextStyle(fontSize: 16)),
                              Text('Postal Code: $postCode',
                                  style: TextStyle(fontSize: 16)),
                              Text('Date: $_selectedValue',
                                  style: TextStyle(fontSize: 16)),
                              Text('Slot Booked: $valueChoose',
                                  style: TextStyle(fontSize: 16)),
                              Text('Service Booked by you : $serviceName',
                                  style: TextStyle(fontSize: 16))
                            ],
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      })
                ],
              ),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 1 ? StepState.complete : StepState.disabled,
            )
          ]),
    );
  }

  Future<void> addUser() {
    return FirebaseFirestore.instance
        .collection("Bookings")
        .doc()
        .set({
          'Name': name,
          'UserId': FirebaseAuth.instance.currentUser!.uid,
          'MobileNumber': mobileNumber,
          'Address': address,
          'PostalCode': postCode,
          'Date': _selectedValue,
          'Slot': valueChoose,
          'Service': serviceName,
          'WorkerName': "Assigned Soon You Will Get Message",
          "WorkerMobileNumber": "Assigned Soon you will Get Message",
          "BookingImage":
              "https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/05/attachment_57184857-e1558020946793.png?auto=format&q=60&fit=max&w=930",
        })
        .then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BookingScreen())))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
