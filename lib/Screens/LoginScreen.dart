import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomeScreen.dart';
import 'RegistrationScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = "";
  bool _obscureText = true;

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      _auth
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen())))
          .catchError((error) => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('May be your Email or Password is wrong'),
                  actions: [
                    ElevatedButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          changeButton = false;
                        });
                      },
                    )
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
              "assets/images/loginImage.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Welcome back",
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
                                "Login",
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
                          'New user? ',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                            child: Text('Sign Up',
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
