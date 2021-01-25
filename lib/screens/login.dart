import 'package:awaride/widgets/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:awaride/widgets/size_config.dart';
import 'package:get/get.dart';
import 'package:awaride/screens/register.dart';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/scheduler.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var _email;
  var _password;
  UserCredential userCredential;

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

  void login() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you in',
      ),
      barrierDismissible: false,
    );
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      /* if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showMessage('Wrong password provided for that user.');
      }*/
      print(e.code);
    }

    if (userCredential != null) {
      print('working');
    } else {
      print('issue');
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
                height: 10 * SizeConfig.blockSizeVertical,
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
                      _buildEmail(),
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
                                child: Text('Sign in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          3 * SizeConfig.safeBlockVertical,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              onPressed: () async {
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult !=
                                        ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
                                  showMessage('No Internet Connection');
                                  return;
                                }
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                _formKey.currentState.save();
                                login();
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
                    Get.to(Register());
                  },
                  child: Text(
                    'Don\'t have an Account . Sign up here',
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
