import 'package:flutter/material.dart';
import 'package:todo/UI/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label,required this.onPressed}) : super(key: key);
 final String label;
 final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment:Alignment.center,
        width:100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: primaryClr
        ),
        child: Text(
          label,
          style:const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          ),
      ),
    );
  }
}
