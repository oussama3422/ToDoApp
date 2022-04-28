import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingPage extends StatelessWidget {
   OnBoardingPage({ Key? key }) : super(key: key);

    OnBoardingContoller contoller=OnBoardingContoller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.black,
        body:SafeArea(
          child: Stack(
            children:[
               PageView.builder(
              controller: contoller.pageController,
              onPageChanged: contoller.selectedPageIndex,
              itemBuilder: ((context, index) {
              return  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text(contoller.onbardingList[index].title,style: const TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Image.asset(contoller.onbardingList[index].imageAssets,height: 400,fit: BoxFit.contain),
                    const SizedBox(height: 20),
                    Text(contoller.onbardingList[index].descreption,style: const TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  
                  ]
              );
            }
            ),
            itemCount: contoller.onbardingList.length,
            ),
            Positioned(
              bottom: 20,
              left: 160,
              child: Row(
                children: 
                  List.generate(
                    contoller.onbardingList.length,
                   (index) => Obx((){
                     return  Container(
                       margin: const EdgeInsets.all(4),
                       width: 12,
                       height: 12,
                       decoration:  BoxDecoration(
                         color: contoller.selectedPageIndex.value == index?Colors.blue:Colors.grey,
                         shape: BoxShape.circle,
                         ),
                     );
                   }),
                   ),
                
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: contoller.forwardAction,
                child:Obx(() => Text(
                  contoller.isLastPage
                  ?
                  'Start'
                  :
                  'Next',
                  style: const TextStyle(color: Colors.white),
                  ),
                  ),
                ),
              ),
            ]
          ),
        ),      
    );
  }
}