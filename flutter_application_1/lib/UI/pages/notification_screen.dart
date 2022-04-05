import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);

  final String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton
           (
            onPressed: () => Get.back(), 
            icon: const Icon(Icons.arrow_back)
            ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Reminder',style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black),),
        centerTitle: true,
      ),
      body: SafeArea(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            const SizedBox(height:10),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.grey,
                ),
                // height: 600,
                width: 400,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                   'Hi,${ _payload.split(';')[0]}',
                    style: TextStyle(fontSize: 30,color: Get.isDarkMode?Colors.white:Colors.black,fontWeight: FontWeight.w900),
                    ),
                  const SizedBox(height: 10,),
                  Text(
                    'You Have New Reminder ',
                    style: TextStyle(fontSize: 20,color: Get.isDarkMode?Colors.white:Colors.black,fontWeight: FontWeight.w900),
                    ),
                ],
                ),
                
                ),
            
            ],
            ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.grey,
                ),
                height: 600,
                width: 400,
                child: SingleChildScrollView(
                  child: Column(
                   mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                           const Icon(Icons.text_format),
                           const SizedBox(width:8),
                           Text('Title : ',style:TextStyle(color:Get.isDarkMode?Colors.white:Colors.black,fontSize:30,fontWeight: FontWeight.w900))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                      _payload.split(';')[1],
                      style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black,fontSize: 13),
                       ),
                      const SizedBox(height:40),
                      Row(
                        children: [
                           const Icon(Icons.description),
                           const SizedBox(width:8),
                           Text('Description : ',style:TextStyle(color:Get.isDarkMode?Colors.white:Colors.black,fontSize:30,fontWeight: FontWeight.w900))
                        ],
                      ),
                      const SizedBox(height: 20),
                     Text(
                      _payload.split(';')[2],
                      style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black,fontSize: 13 ),
                      textAlign: TextAlign.justify,
                      ),
                     const SizedBox(height:40),
                     Row(
                        children: [
                           const Icon(Icons.calendar_today),
                           const SizedBox(width:8),
                           Text('Date : ',style:TextStyle(color:Get.isDarkMode?Colors.white:Colors.black,fontSize:30,fontWeight: FontWeight.w900))
                        ],
                      ),
                      const SizedBox(height: 20),
                     Text(
                      _payload.split(';')[3],
                      style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black,fontSize: 13 ),
                      textAlign: TextAlign.justify,
                      ),
                      
                    ],
                  ),
                ),
              ) ,
            ),
              ],
              ),
        
      
      ),
    );
  }
}
