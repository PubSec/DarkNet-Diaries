import 'package:flutter/material.dart';

class AnimWidget extends StatefulWidget {
  const AnimWidget({super.key});

  @override
  State<AnimWidget> createState() => _AnimWidgetState();
}

class _AnimWidgetState extends State<AnimWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child:  Column())
    );
  }
}
