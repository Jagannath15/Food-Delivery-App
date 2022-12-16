
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Screens/home.dart';
import 'package:get/get.dart';

import '../Controllers/detail_page_controller.dart';


class DetailPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
   DetailPage({Key? key,
   required this.documentSnapshot}) : super(key: key);
 final DetailController c=Get.put(DetailController());
  @override

  addtocart() async{
    FirebaseAuth _auth=FirebaseAuth.instance;
    var curremtuser=_auth.currentUser;
    CollectionReference collectionReference=FirebaseFirestore.instance.collection("add_to_cart");
     return collectionReference.doc(curremtuser!.phoneNumber).collection("items").doc(documentSnapshot['name']).set({
      "name":documentSnapshot['name'],
      "price":documentSnapshot['Price'],
       "quantity":c.quantity.toString(),
       "img":documentSnapshot['imageUrl']

    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [    
                Container(
                  height: 320,
                  child: Image(image: NetworkImage(documentSnapshot['imageUrl']),),
                ),
                InkWell(
                  onTap: () => Get.to(Home()),
                  child: Container(
                    margin: EdgeInsets.only(top: 4,left: 8),
                    width: 23,
                    height: 23,
                    child: Icon(Icons.arrow_back_ios,size: 26,)
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1f1f1f),
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(25),
                    topRight: Radius.circular(25)
                ),
            ),
                child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(documentSnapshot['name'],style: TextStyle(color: Colors.white,fontSize: 27,fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        )),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Text("₹ "+documentSnapshot['Price'],style: TextStyle(color: Colors.white ,fontSize: 25,fontWeight: FontWeight.bold),)  
                    ],
                  ),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0xffFFD700),),
                    Icon(Icons.star,color: Color(0xffFFD700),),
                    Icon(Icons.star,color: Color(0xffFFD700),),
                    Icon(Icons.star,color: Color(0xffFFD700),),
                    Icon(Icons.star,color: Color(0xffFFD700),),
                       Flexible(fit: FlexFit.tight, child: SizedBox()),
                       Icon(Icons.alarm,color: Colors.white,),
                    Text(" 10-15mins",style: TextStyle(color: Colors.white54 ),)  
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 120,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(documentSnapshot['desc'],style: TextStyle(color: Colors.white),),
                        ),
                      )
                    
                    )
                  ],
                ),



                  Row(
                    children: [
                     Container(
                        height: 45,
                        width: 123, 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
      
                        ),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(onPressed: (){
                              c.decrement();
                            }, icon: Icon(Icons.remove,size: 25,)),
                          //  SizedBox(width: 5,),
                            Obx(()=>Text("${c.quantity.toString()}", style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ,)),
                           // SizedBox(width: 5,),
                            IconButton(onPressed: (){
                               c.increment();}, icon: Icon(Icons.add,size: 25,))
                          ],
                        ),
                     ),
                     // Text(documentSnapshot['Price'],style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.w500),),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      InkWell(
                        onTap: (){
                          addtocart();
                        },
                        child: Container(
                          height: 55,
                          width: 190,
                          decoration: BoxDecoration(
                            color: Color(0xffccff01),
                            borderRadius: BorderRadius.circular(15)
                          ),
                         
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Icon(Icons.shopping_cart,size: 30,),
                                  SizedBox(width: 10,),
                                  Text("Add to cart",style: TextStyle(fontSize: 18),)
                              ],
                            ),
                         
                        ),
                      )
                    ],
                  )



                ],
              ),
            ),
            ),
            )
          ]
        ),
      ),
    );
  }
}