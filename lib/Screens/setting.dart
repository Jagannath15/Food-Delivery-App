import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Screens/setting_all_orders.dart';
import 'package:food_delivery_app/main.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override


  logout()async{
            SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.setBool("finalLogin", true);
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                Get.to(StartPage());
        }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffEAEFF2),
      appBar: AppBar(title: Text("Settings",style: TextStyle(color: Colors.black),),backgroundColor:  Color(0xffEAEFF2),elevation: 0,foregroundColor: Colors.black,),
      body: Column(
        children: [
          InkWell(
            onTap: (){
              Get.to(()=>AllOrders());
            },
            child: Container(
              margin: EdgeInsets.all(8),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("All Orders",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17))
                ],
              ),
            ),



            
          ),

          InkWell(
            onTap: () => logout(),
            child: Container(
                margin: EdgeInsets.all(10),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Log out",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17))
                  ],
                ),
              ),
          ),
        ],
      )
    
    );

  }
}