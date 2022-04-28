import 'package:flutter/material.dart';
import 'package:todo/UI/theme.dart';

class MyButton extends StatelessWidget {
 MyButton({required this.icon,required this.label,required this.onPressed});
 final String label;
 final Function() onPressed;
 final Icon icon;

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
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
                label,
                style:const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                ),
          ],
        ),
      ),
    );
  }
}
