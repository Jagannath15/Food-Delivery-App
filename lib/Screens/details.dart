
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      body: Column(
        children: [
         
          Container(
            height: 320,
            child: Image(image: NetworkImage(documentSnapshot['imageUrl'])),
          ),
          Expanded(child: Container(
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
                    Text(documentSnapshot['name'],style: TextStyle(color: Colors.white,fontSize: 27,fontWeight: FontWeight.bold),),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Icon(Icons.alarm,color: Colors.white,),
                    Text(" 10-15mins",style: TextStyle(color: Colors.white54 ),)  
                  ],
                ),
                Row(
                  children: [
                   Container(
                      height: 45,
                      width: 123, 
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white54,

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
    );
  }
}