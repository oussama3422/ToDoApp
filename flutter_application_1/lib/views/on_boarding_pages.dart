import 'package:flutter/material.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingPage extends StatelessWidget {
   OnBoardingPage({ Key? key }) : super(key: key);

    OnBoardingContoller contoller=OnBoardingContoller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:PageView.builder(
          itemBuilder: ((context, index) {
          return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text(contoller.onbardingList[index].title),
                const SizedBox(height: 20),
                Image.asset(contoller.onbardingList[index].imageAssets,height: 400,),
                const SizedBox(height: 20),
                Text(contoller.onbardingList[index].descreption),
              ]
          );
          
        }
        ),
        itemCount: contoller.onbardingList.length,
        ),      
    );
  }
}