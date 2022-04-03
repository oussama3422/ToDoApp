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
      padding: const EdgeInsets.only(top:10,bottom: 7),
      // decoration: BoxDecoration(
      //   // color: Get.isDarkMode?Colors.purple:Colors.grey,
      //   borderRadius: BorderRadius.circular(10),
      //   // border: Border.all(color: Colors.orange)
      // ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
          Text(title,style:titleStyle),
          Container(
          padding: const EdgeInsets.only(left: 9),
          width: SizeConfig.screenWidth,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                controller: controller,
                autofocus: false,
                style: subheadingStyle,
                cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[200],
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: suubTitleStyle,
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color:  Colors.white)),
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
