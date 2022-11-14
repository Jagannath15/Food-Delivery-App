import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/models/recommended.dart';

class DetailPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
   
   DetailPage({Key? key,
   required this.documentSnapshot}) : super(key: key);

  @override
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
                    Text(documentSnapshot['Price'],style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.w500),),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Container(
                      height: 60,
                      width: 230,
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