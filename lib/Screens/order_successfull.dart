import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Screens/home.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Order_Succesfull extends StatelessWidget {
  final id;
  const Order_Succesfull({Key? key , required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafdfb),
      body: Center(
        child: Column(   
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/100518-success-anime.json"),
            SizedBox(height: 10,),
            Text("Your Order has been successfully placed",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            SizedBox(height: 5,),
            Text("Order Id: "+id)
          ],
        ),
      ),

      bottomNavigationBar: GestureDetector(
        onTap: (){
          Get.to(()=>Home());
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Color(0xffccff01),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text("Continue to order more",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}