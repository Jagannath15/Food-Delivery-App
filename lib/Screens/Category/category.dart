import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Screens/details.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CategoryPage extends StatelessWidget {
  var cat;
  CategoryPage({super.key, this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAEFF2),
      body: Column(
        children: [
          StreamBuilder(
              stream: cat,
              builder: ((BuildContext context,
                  AsyncSnapshot streamSnapshot) {
                
                if (streamSnapshot.hasData) {
            
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder:(context, index) {
                          var doc=streamSnapshot.data!.docs[index];
                            return 
                               InkWell(
                                onTap: () => Get.to(()=>DetailPage(documentSnapshot: doc)),
                                 child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                               

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                 boxShadow: [
                                    BoxShadow(
                                     color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 4
                                    )
                                 ]
                                  ),

                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        foregroundImage: NetworkImage(doc['imageUrl']),
                                        radius: 25,
                                      ),
                                      SizedBox(width: 5,),
                                      Text(doc['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                                      Text("₹"+doc['Price'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))
                                    ],
                                  ),
                                                             ),
                               );
                          
                        },
                        );
                }
              return CircularProgressIndicator();
              }
              )
              )
        ],
      ),
    );
  }
}
