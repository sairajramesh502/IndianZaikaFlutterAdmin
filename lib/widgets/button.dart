// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class ButtonGlobal extends StatefulWidget {
  final GestureTapCallback? onPressed;
  final String buttonText;
  const ButtonGlobal(
      {Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  @override
  _ButtonGlobalState createState() => _ButtonGlobalState();
}

class _ButtonGlobalState extends State<ButtonGlobal> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.amber,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: Text(
          widget.buttonText,
          style: const TextStyle(
              color: Color(0xFF272C2F),
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
