import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Screens/details.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../Controllers/search_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

 
  @override
//   final Search_controller d=Get.put(Search_controller());
List searchlist=[];

    late  QuerySnapshot result;
    void searchproduct(String text) async{
       result = await FirebaseFirestore.instance.collection("all_items").where('name', isEqualTo: text).get();
    //  print(d.searchlist);
      setState(() {
         searchlist=result.docs.map((e) => e.data()).toList();
      });
      print(searchlist);
    }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAEFF2),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
                 Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xff1f1f1f),
                    borderRadius: BorderRadius.only( 
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      )
                      
                  ),
                   child: TextField(
                    cursorColor:Color(0xff969696) ,
                    style: TextStyle(color:Color(0xff969696),fontSize: 16 ),
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.search,color:Color(0xff969696) ,),
                      fillColor: Color(0xff393939),
                       enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                               hintText: "Search Something for Tasty...",
                              hintStyle: TextStyle(color: Color(0xff969696),fontSize: 16),
                              
                    ),
                    onChanged: (value) =>searchproduct(value) ,
                   ),
                 ),
              

              
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount:searchlist.length,
                      itemBuilder: (context,index){
                        return InkWell(
                        //  onTap: () => DetailPage(documentSnapshot ),
                          child: Material(
                            elevation: 15,
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                dense: true,
                                  leading: searchlist[index]['imageUrl']==null? CircularProgressIndicator()  :CircleAvatar(foregroundImage: NetworkImage(searchlist[index]["imageUrl"]),radius:25),
                                  title: Text(searchlist[index]['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                 trailing: Text("₹"+searchlist[index]['Price'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                    
                              ),
                            ),
                          ),
                        );
                      }
                      
                      ),
                )
                    
            ],
          ),
        ),
      ),
    );
  }
}