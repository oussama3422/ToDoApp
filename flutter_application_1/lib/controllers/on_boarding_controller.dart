

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/UI/pages/home_page.dart';
import 'package:todo/models/on_boarding_info.dart';

class OnBoardingContoller extends GetxController {
     var selectedPageIndex=0.obs;
     
     bool get isLastPage{
       return selectedPageIndex.value == onbardingList.length-1;
     }

     var pageController = PageController();

    forwardAction(){
      if(isLastPage)
      {
        Get.to(()=>const HomePage());
    }else{
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.easeIn);
    }
    }
     
    List<OnBoardingInfo> onbardingList=[
      OnBoardingInfo('images/page.png', 'ToDoList', 'We do To do List Just For Uu.'),
      OnBoardingInfo('images/page2.png', 'Create Note', 'Create Successfully Notes.'),
      OnBoardingInfo('images/unnamed.png', 'License', 'Copyright 2022 App.All Rights Reserved.'),
      OnBoardingInfo('images/mypic.jpeg', 'Owner', 'To Do List App\'s Developer'),
    ];
   


}