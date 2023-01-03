import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text("All Orders",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,elevation: 0,),
      body:SingleChildScrollView(
        child: StreamBuilder(
          stream:FirebaseFirestore.instance.collection("Orders").doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection("items").snapshots() ,
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
            if (streamSnapshot.hasData) {
              return ListView.builder(
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                 itemCount: streamSnapshot.data!.docs.length,
                 itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =streamSnapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color(0xffe5e4e2),
                  ),
                  child: Row(
                    children: [
                      Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text("Orders: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Text(documentSnapshot['Items Orders'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Order Id: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Text(documentSnapshot['Order ID'])
                            ],
                          ),
                          Row(
                            children: [
                              Text("Status: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Text(documentSnapshot['Status'])
                            ],
                          ),
                          Row(
                            children: [
                               Text("Total amount paid: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Text("₹"+documentSnapshot['total'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15))
                            ],
                          )

                        ],
                      )
                    ],
                  ),
                );
                }
                
                
                );
          }
          return CircularProgressIndicator();
          }
              ),
      ),
    );
  }
}