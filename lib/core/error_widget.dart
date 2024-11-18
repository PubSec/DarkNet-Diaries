import 'package:darknet_diaries/core/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  String errorMessage;
  ErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darknetBlack,
      height: 100,
      width: 100,
      child: Column(
        children: [
          Center(
            child: Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 50,
              color: darknetRed,
            ),
          ),
          SizedBox(height: 50),
          Text(errorMessage),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }
}
