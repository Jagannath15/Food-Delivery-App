import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Topcategories(
  String text, String image
){
  return  GestureDetector(
    onTap: (){},
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