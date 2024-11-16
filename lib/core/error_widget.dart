import 'package:darknet_diaries/core/constant.dart';
import 'package:flutter/cupertino.dart';

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
              size: 30,
              color: darknetRed,
            ),
          ),
          Text(errorMessage)
        ],
      ),
    );
  }
}
