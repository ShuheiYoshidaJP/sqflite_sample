import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WideWidthButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final void Function() tapped;

  const WideWidthButton(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.tapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints.tightFor(width: double.infinity, height: 50),
      child: ElevatedButton(
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: textColor,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: tapped,
      ),
    );
  }
}
