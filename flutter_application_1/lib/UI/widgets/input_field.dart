import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/UI/size_config.dart';
import 'package:todo/UI/theme.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    }
    
    ) ;

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
          Text(title,style:titleStyle),
          Container(
          padding: const EdgeInsets.only(top: 8),
          margin: const EdgeInsets.only(left: 13),
          width: SizeConfig.screenWidth,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey)
          ),
          child: Row(
            children: [
              Expanded(child: TextFormField(
                controller: controller,
                autofocus: false,
                style: subheadingStyle,
                cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[200],
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: suubTitleStyle,
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.black)),
                  ),
                
              )),
              widget ?? Container(),
            ],
          ),
    ),
        ],
      ),
      );
  }
}
