
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Widgets/recommended_items.dart';
import 'package:food_delivery_app/Widgets/topcategories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String ?mobno;
  @override
  void initState(){
    // TODO: implement initState
    getusemob();
  }

  void getusemob() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
     mobno=prefs.getString("UserMobile");
  }
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xfff6f5f8),
  
      body: 
         SafeArea(
           child: SingleChildScrollView(child: Column(
            children: [
             Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff1f1f1f),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18),bottomRight: Radius.circular(18))
              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(      
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text("Eat and Greet",style: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold))),   
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Container(
                        height: 30,
                        width: 60,             
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xffccff01),
                          borderRadius: BorderRadius.circular(9),
                        ),
                          child: Center(
                            child: Row(
                              children: [
                              SizedBox(width: 11,),
                              Icon(Icons.shopify_rounded,),
                              SizedBox(width: 2,),
                              Text("1")
                            ],),
                          ),
                      ),
                    ],
                  ), 
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 5),
                          child: TextField(
                            cursorColor: Color(0xff969696),
                            style: TextStyle(color: Color(0xff969696)),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search,size: 30,color: Color(0xff969696),),
                              filled: true,
                              fillColor: Color(0xff393939),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              hintText: "Search Something for Tasty...",
                              hintStyle: TextStyle(color: Color(0xff969696)),
                               )         
                    ),
                        ),
                 
                ],
              ),
             ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Top Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  InkWell(
                    child: Row(
                      children: [
                        Text("View all",style: TextStyle(fontSize: 13,color: Color(0xff969696)),),
                        Icon(Icons.arrow_forward,size: 18,color: Color(0xff969696),)
                      ],
                    )                  )
                ],
              ),
            ),
          SizedBox(height: 10,),
           Container(
           height: 45,
          margin: EdgeInsets.all(5),
             child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              
              children: [
              Topcategories("Burger","assets/icons/burger.png"),
              Topcategories("Pizza","assets/icons/pizza.png"),
              Topcategories("Sandwich","assets/icons/sandwich.png"),
              Topcategories("Chicken","assets/icons/chicken.png"),
              Topcategories("Wrap","assets/icons/wrap.png"),
              Topcategories("Veg Salad","assets/icons/vegsalad.png"),
              Topcategories("Desert","assets/icons/desert.png"),
             
              ],
             ),
           ),
           SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Recommended for You",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  InkWell(
                    child: Row(
                      children: [
                        Text("View all",style: TextStyle(fontSize: 13,color: Color(0xff969696)),),
                        Icon(Icons.arrow_forward,size: 18,color: Color(0xff969696),)
                      ],
                    )                  )
                ],
              ),
            ),

            SizedBox(height: 10,),
             Container(
           height: 200,
            margin: EdgeInsets.all(5),
             child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true, 
              children: [
            Recommended("assets/burger2.png", "Burger", "54145"),
            Recommended("assets/burger2.png", "Burger", "54145"),
            Recommended("assets/burger2.png", "Burger", "54145"),
            Recommended("assets/burger2.png", "Burger", "54145"),
             Recommended("assets/burger2.png", "Burger", "54145"),
            Recommended("assets/burger2.png", "Burger", "54145"),
             Recommended("assets/burger2.png", "Burger", "54145"),
            Recommended("assets/burger2.png", "Burger", "54145"),
            ],
             ),
           ),



            ],
                 ),),
         ),
      );
    
  }
}