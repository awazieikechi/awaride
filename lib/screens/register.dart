import 'package:flutter/material.dart';
import 'package:awaride/widgets/size_config.dart';
import 'package:get/get.dart';
import 'package:awaride/screens/login.dart';
import 'package:awaride/screens/mainpage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var _email;
  var _password;
  var _fullname;
  var _phonenumber;
  UserCredential userCredential;

  FirebaseAuth auth = FirebaseAuth.instance;

  Widget _buildFullName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Full Name',
        labelStyle: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),
        filled: true,
        hintStyle: TextStyle(
            color: Colors.grey, fontSize: 1.5 * SizeConfig.blockSizeVertical),
        hintText: 'Email',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Full Name is required';
        }

        if (value.length <= 3) {
          return 'Please Provide a Valid Full Name';
        }
      },
      onSaved: (String value) {
        _fullname = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        labelStyle: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),
        filled: true,
        hintStyle: TextStyle(
            color: Colors.grey, fontSize: 1.5 * SizeConfig.blockSizeVertical),
        hintText: 'Email',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Full Name is required';
        }

        if (value.length < 10) {
          return 'Please Provide a Valid Phone Number';
        }
      },
      onSaved: (String value) {
        _phonenumber = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),
        filled: true,
        hintStyle: TextStyle(
            color: Colors.grey, fontSize: 1.5 * SizeConfig.blockSizeVertical),
        hintText: 'Email',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        }

        if (!value.contains('@')) {
          return 'Please Provide a Valid Email';
        }
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),
        filled: true,
        hintStyle: TextStyle(
            color: Colors.grey, fontSize: 1.5 * SizeConfig.blockSizeVertical),
        hintText: 'Password',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  void showMessage(String message) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Flushbar(
          messageText: Text(message,
              style: TextStyle(
                  fontSize: 2.5 * SizeConfig.safeBlockVertical,
                  color: Colors.white)),
          icon: Icon(
            Icons.info_outline,
            size: 4 * SizeConfig.safeBlockVertical,
            color: Colors.blue[300],
          ),
          duration: Duration(seconds: 8),
          leftBarIndicatorColor: Colors.blue[300],
          backgroundColor: Colors.black)
        ..show(context);
    });
  }

  void registerUser() async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showMessage('The account already exists for that email.');
      }
    } catch (e) {
      showMessage(e);
    }

    if (userCredential != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('userPhoneNumber', _phonenumber);
      localStorage.setString('userFullName', _fullname);
      Get.to(MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4 * SizeConfig.blockSizeHorizontal),
          child: Column(
            children: [
              SizedBox(
                height: 2 * SizeConfig.blockSizeVertical,
              ),
              Image(
                  alignment: Alignment.center,
                  width: 40 * SizeConfig.blockSizeHorizontal,
                  height: 20 * SizeConfig.blockSizeVertical,
                  image: AssetImage('assets/images/logo-5.jpg')),
              SizedBox(
                height: 2 * SizeConfig.blockSizeVertical,
              ),
              Text(
                'Sign in',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 5.6 * SizeConfig.safeBlockVertical,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.blockSizeVertical,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildFullName(),
                      SizedBox(
                        height: 2 * SizeConfig.blockSizeVertical,
                      ),
                      _buildEmail(),
                      SizedBox(
                        height: 2 * SizeConfig.blockSizeVertical,
                      ),
                      _buildPhoneNumber(),
                      SizedBox(
                        height: 2 * SizeConfig.blockSizeVertical,
                      ),
                      _buildPassword(),
                      SizedBox(
                        height: 2 * SizeConfig.blockSizeVertical,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RaisedButton(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    3 * SizeConfig.blockSizeVertical),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    3 * SizeConfig.blockSizeVertical),
                                child: Text('REGISTER',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          3 * SizeConfig.safeBlockVertical,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              onPressed: () async {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                _formKey.currentState.save();
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult !=
                                        ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
                                  print('working');
                                  print('No Internet Connection');
                                  showMessage('No Internet Connection');

                                  return;
                                }
                              }),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 2 * SizeConfig.blockSizeVertical,
              ),
              FlatButton(
                  onPressed: () {
                    Get.to(Login());
                  },
                  child: Text(
                    'Already have an Account . Log in here',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 2 * SizeConfig.safeBlockVertical,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                    ),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
