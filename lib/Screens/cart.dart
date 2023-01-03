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
var mainpay=0;
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor:  Color(0xffEAEFF2),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.to(Home());
        }, icon: Icon(Icons.arrow_back_rounded,size: 30,color: Colors.black54,)),
        elevation: 0,
        title: Text("Checkout",style: TextStyle(color: Colors.black),),
        backgroundColor:  Color(0xffEAEFF2),
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
                    color: Colors.white,
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
                          Expanded(
              
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(_doc['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis,))),
                          Row(
                            
                            children: [
                              Text("Quantity: "+_doc['quantity'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,)),
                              SizedBox(width: 10,),
                              Text("₹"+total,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black), ),
                            ],
                          ), 
                        ],
                      ),
                      SizedBox(width: 10,),
                      
                      IconButton(onPressed: (){ 
                        FirebaseFirestore.instance.collection("add_to_cart").doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection("items").doc(_doc['name']).delete();
                      }, icon: Icon(Icons.remove_shopping_cart),),

                    ],
                  )
                );
              }
            
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black26,
            ),
          );
        }
        ),
      ),
      bottomNavigationBar: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("add_to_cart").doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection("items").snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
              if(streamSnapshot.hasData){
                double total=0;
                double price,quantity;
                for (var i = 0; i < streamSnapshot.data!.docs.length; i++){
                  DocumentSnapshot _doc=streamSnapshot.data!.docs[i];
                  price=double.parse(_doc['price']);
                  quantity=double.parse(_doc['quantity']);
                  total=total+price*quantity;
                  print(total);
                  
                }
    
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Billing(total: total.toString(),)));
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
                                Text("Total ₹"+total.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              ],
                            ),
                  ),
                );
              }
              return Container(
            margin: EdgeInsets.all(8),
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xffccff01),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_checkout),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Total ₹ 0",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
                            ),
                  );
            } , 
            ),   
      
    );
  }
}