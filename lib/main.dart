import 'package:flutter/material.dart';
import 'package:awaride/widgets/size_config.dart';
import 'package:get/get.dart';
import 'package:awaride/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.key,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.red),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 4 * SizeConfig.blockSizeHorizontal),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, 4 * SizeConfig.blockSizeHorizontal, 0),
                    child: Container(
                        height: 62 * SizeConfig.blockSizeVertical,
                        width: 4.5 * SizeConfig.blockSizeHorizontal,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                                2.5 * SizeConfig.blockSizeHorizontal),
                            bottomRight: Radius.circular(
                                2.5 * SizeConfig.blockSizeHorizontal),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 2 * SizeConfig.blockSizeHorizontal,
                  ),
                  Column(
                    children: [
                      Container(
                          height: 50 * SizeConfig.blockSizeVertical,
                          width: 4.5 * SizeConfig.blockSizeHorizontal,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                  2.5 * SizeConfig.blockSizeHorizontal),
                              bottomRight: Radius.circular(
                                  2.5 * SizeConfig.blockSizeHorizontal),
                            ),
                          )),
                      SizedBox(
                        height: 1 * SizeConfig.blockSizeVertical,
                      ),
                      Container(
                        height: 3 * SizeConfig.blockSizeVertical,
                        width: 4.5 * SizeConfig.blockSizeHorizontal,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 4 * SizeConfig.blockSizeHorizontal,
                  ),
                  Container(
                      height: 40 * SizeConfig.blockSizeVertical,
                      width: 4.5 * SizeConfig.blockSizeHorizontal,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              2.5 * SizeConfig.blockSizeHorizontal),
                          bottomRight: Radius.circular(
                              2.5 * SizeConfig.blockSizeHorizontal),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 110 * SizeConfig.blockSizeHorizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 3 * SizeConfig.blockSizeHorizontal),
              child: Row(
                children: [
                  Text('Awa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8 * SizeConfig.safeBlockVertical,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w900,
                      )),
                  Text('Ride!',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 8 * SizeConfig.safeBlockVertical,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w900,
                      )),
                ],
              ),
            )),
        Positioned(
            top: 135 * SizeConfig.blockSizeHorizontal,
            left: 20 * SizeConfig.blockSizeHorizontal,
            child: Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(3 * SizeConfig.blockSizeVertical),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3 * SizeConfig.blockSizeVertical),
                    child: Text('Welcome!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 4.8 * SizeConfig.safeBlockVertical,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  onPressed: () {
                    Get.to(Login());
                  }),
            )),
      ],
    )));
  }
}
