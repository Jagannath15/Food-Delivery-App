import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/Category/category.dart';
import 'package:get/get.dart';

Widget Topcategories(
  String text, String image, String category
){
  return  GestureDetector(
    onTap: () async{
                var c= await FirebaseFirestore.instance.collection("all_items").where('cat',isEqualTo: category).get().asStream() ;
                Get.to(CategoryPage(cat: c));
                },
    child: Container(
                  margin: EdgeInsets.only(left: 8),
                // padding: EdgeInsets.all(5),
                padding: EdgeInsets.only(top: 5,bottom: 5),
  
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                
                  ),
                  child: Row(children: [
                    CircleAvatar(foregroundImage: AssetImage(image),
                    backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 5,),
                    Text(text,style: TextStyle(fontWeight: FontWeight.bold),)
                  ]),
                 ),
  );
}