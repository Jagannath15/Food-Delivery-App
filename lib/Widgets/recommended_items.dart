import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Recommended(
  String image,
  String food_name,
  String food_rate,
){
  return  
                Container(
                  height:180 ,
                  width: 160,
                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        color: Colors.transparent,
                        child: Image.asset(image),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(food_name),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(food_rate)
                        ],
                      )
                    ],
                  ),
                );
            
  
                
}