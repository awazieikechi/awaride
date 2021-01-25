import 'package:awaride/widgets/size_config.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String status;

  ProgressDialog({this.status});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(3 * SizeConfig.blockSizeHorizontal)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(2.6 * SizeConfig.blockSizeVertical),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 1 * SizeConfig.blockSizeHorizontal,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.amber),
            ),
            SizedBox(
              width: 6 * SizeConfig.blockSizeHorizontal,
            ),
            Text(
              status,
              style: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeHorizontal),
            ),
          ],
        ),
      ),
    );
  }
}
