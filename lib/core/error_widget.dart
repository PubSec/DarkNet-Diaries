import 'package:darknet_diaries/core/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  String errorMessage;
  ErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: AlertDialog(
          icon: Icon(
            CupertinoIcons.exclamationmark_octagon,
            color: darknetRed,
          ),
          title: Text(
            "Error",
            style: TextStyle(color: darknetWhite),
          ),
          content: Text(
            errorMessage,
            style: TextStyle(color: darknetWhite),
          ),
        ),
      ),
    );
  }
}
