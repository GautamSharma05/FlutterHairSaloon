import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomeScreen.dart';
import 'LoginScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore fStore = FirebaseFirestore.instance;
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });

      CollectionReference documentReference = fStore.collection('Users');
      _auth
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text)
          .then((value) => documentReference
              .doc(value.user!.uid)
              .set({
                'UserId': value.user!.uid,
                'FullName': _fullNameController.text,
                'MobileNumber': _phoneNumberController.text,
                'Email': _emailController.text
              })
              .then((value) => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen())))
              .catchError((error) => print("Failed to add user: $error")))
          .catchError((error) => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text(
                      "Check you Internet Connection or May be your email is wrong Check and Try Again"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            changeButton = false;
                          });
                        },
                        child: Text('Ok'))
                  ],
                );
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Image.asset(
              "assets/images/signupImage.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Welcomes You!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      hintText: "Enter you Name",
                      labelText: "Full Name",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Full Name cannot be empty";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: "Enter you Mobile number",
                      labelText: "Mobile Number",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mobile number cannot be empty";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      } else if (!EmailValidator.validate(value)) {
                        return "Please Type Valid Email";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      labelText: "Password",
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      } else if (value.length < 6) {
                        return "Password length should be atleast 6";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Material(
                    color: Color(0xFFFDBAA4),
                    borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
                    child: InkWell(
                      onTap: () => moveToHome(context),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        width: changeButton ? 50 : 150,
                        height: 50,
                        alignment: Alignment.center,
                        child: changeButton
                            ? Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : Text(
                                "Registration",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1.0),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have An Account? ',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text('Login',
                                style: TextStyle(
                                    color: Color(0xFFFDBAA4),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
