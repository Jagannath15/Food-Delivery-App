import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Screens/home.dart';
import 'package:food_delivery_app/Screens/payment.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CartPage extends StatelessWidget {
   CartPage({Key? key}) : super(key: key);
  
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.to(Home());
        }, icon: Icon(Icons.arrow_back_rounded,size: 30,color: Colors.black54,)),
        elevation: 0,
        title: Text("Checkout",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("add_to_cart").doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection("items").snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
              shrinkWrap: true,
              itemCount: streamSnapshot.data!.docs.length,
              
              itemBuilder: (_,index){
                DocumentSnapshot _doc=streamSnapshot.data!.docs[index];
                int Fprice=int.parse(_doc['price']);
                int Fquantity=int.parse(_doc['quantity']);
                var intialtotal=Fprice*Fquantity;
                String total=intialtotal.toString();

                


                return Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color(0xffd7d8da),
                    borderRadius: BorderRadius.all(Radius.circular(15)), 
                                      ),
                  margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        foregroundColor: Colors.transparent,
                        foregroundImage: NetworkImage(_doc['img']),
                        backgroundColor: Colors.transparent,
                         radius: 40,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_doc['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                          Text("Quantity: "+_doc['quantity'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,)), 
                        ],
                      ),
                      SizedBox(width: 10,),
                      Text("₹"+total,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green), ),
                      IconButton(onPressed: (){
                        FirebaseFirestore.instance.collection("add_to_cart").doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection("items").doc(_doc['name']).delete();
                      }, icon: Icon(Icons.remove_shopping_cart),splashColor: Colors.amber,),

                    ],
                  )
                );
              }
            
            );
          }
          return CircularProgressIndicator(
            color: Colors.black54,
          );
        }
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Get.to(Billing());
        },
        child: Container(
          margin: EdgeInsets.all(8),
          height: 55,
          width: MediaQuery.of(context).size.width,
        
          decoration: BoxDecoration(
            color: Color(0xffccff01),
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_checkout),
              SizedBox(width: 2,),
              Text("proceed",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}