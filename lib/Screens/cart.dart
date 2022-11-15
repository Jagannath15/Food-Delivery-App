import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartPage extends StatelessWidget {
   CartPage({Key? key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
               
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xffd7d8da),
                    borderRadius: BorderRadius.all(Radius.circular(15)), 
                                      ),
                  margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                  height: 100,
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
                          Text("Quantity: "+_doc['quantity'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,)), 
                        ],
                      ),
                      SizedBox(width: 10,),
                      Text("₹"+_doc['price'],style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.green), ),
                      IconButton(onPressed: (){
                        FirebaseFirestore.instance.collection("add_to_cart").doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection("items").doc(_doc['name']).delete();
                      }, icon: Icon(Icons.remove_shopping_cart),splashColor: Colors.amber,)
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
    );
  }
}